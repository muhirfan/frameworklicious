//
//  ContentBasedRecommender.swift
//  CoreML Demo V2
//
//  Created by Kaushik Manian on 2/5/25.
//

import Foundation

/// Content-based recommender using cosine similarity on one-hot genre vectors.
struct ContentBasedRecommender {
    private let movieVectors: [Int: [Double]]
    private let titles: [Int: String]

    init(moviesCSV url: URL) throws {
        let text  = try String(contentsOf: url, encoding: .utf8)
        let lines = text.components(separatedBy: "\n").dropFirst()

        // 1) Gather all genres
        var genreSet = Set<String>()
        var rawData = [(id: Int, title: String, genres: [String])]()
        for line in lines where !line.isEmpty {
            let parts = line.components(separatedBy: ",")
            guard parts.count >= 3, let id = Int(parts[0]) else { continue }
            let title  = parts[1]
            let genres = parts[2].components(separatedBy: "|")
            rawData.append((id, title, genres))
            genres.forEach { genreSet.insert($0) }
        }

        // 2) Build one-hot index
        let allGenres  = Array(genreSet).sorted()
        let genreIndex = Dictionary(uniqueKeysWithValues:
            allGenres.enumerated().map { ($1, $0) }
        )

        // 3) Encode each movie
        var vectors   = [Int: [Double]]()
        var titlesMap = [Int: String]()
        for entry in rawData {
            var vec = Array(repeating: 0.0, count: allGenres.count)
            for g in entry.genres {
                if let idx = genreIndex[g] {
                    vec[idx] = 1.0
                }
            }
            vectors[entry.id]   = vec
            titlesMap[entry.id] = entry.title
        }

        self.movieVectors = vectors
        self.titles       = titlesMap
    }

    /// Returns the top-K titles by descending cosine similarity.
    func recommend(similarTo movieId: Int, topK: Int = 5) -> [String] {
        similarityScores(similarTo: movieId, topK: topK).map { $0.title }
    }

    /// Returns raw (title, cosineScore) pairs so you can inspect or log them.
    func similarityScores(similarTo movieId: Int, topK: Int = 5)
      -> [(title: String, score: Double)]
    {
        guard let target = movieVectors[movieId] else { return [] }
        let tNorm = sqrt(target.map { $0 * $0 }.reduce(0, +))

        var scored = [(String, Double)]()
        for (id, vec) in movieVectors {
            guard id != movieId else { continue }
            let dot   = zip(target, vec).map(*).reduce(0, +)
            let vNorm = sqrt(vec.map { $0 * $0 }.reduce(0, +))
            guard tNorm > 0, vNorm > 0 else { continue }
            let cos = dot / (tNorm * vNorm)
            if let title = titles[id] {
                scored.append((title, cos))
            }
        }

        return scored
            .sorted(by: { $0.1 > $1.1 })
            .prefix(topK)
            .map { ($0.0, $0.1) }
    }
}
