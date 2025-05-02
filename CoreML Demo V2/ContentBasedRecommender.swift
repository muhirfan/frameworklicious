//
//  ContentBasedRecommender.swift
//  CoreML Demo V2
//
//  Created by Kaushik Manian on 2/5/25.
//

import Foundation

/// A very basic cosine-similarity recommender based on movie genres.
struct ContentBasedRecommender {
    private let movieVectors: [Int: [Double]]
    private let titles: [Int: String]

    init(moviesCSV url: URL) throws {
        let text = try String(contentsOf: url, encoding: .utf8)
        let lines = text.components(separatedBy: "\n").dropFirst()

        var genreSet = Set<String>()
        var raw: [(id: Int, title: String, genres: [String])] = []
        for line in lines where !line.isEmpty {
            let cols = line.components(separatedBy: ",")
            guard cols.count >= 3,
                  let id = Int(cols[0]) else { continue }
            let title  = cols[1]
            let genres = cols[2].components(separatedBy: "|")
            raw.append((id, title, genres))
            genres.forEach { genreSet.insert($0) }
        }

        let allGenres   = Array(genreSet).sorted()
        let genreIndex  = Dictionary(uniqueKeysWithValues:
            allGenres.enumerated().map { ($1, $0) }
        )

        var vectors = [Int: [Double]]()
        var titlesMap = [Int: String]()
        for (id, title, genres) in raw {
            var v = Array(repeating: 0.0, count: allGenres.count)
            for g in genres {
                if let idx = genreIndex[g] { v[idx] = 1.0 }
            }
            vectors[id]     = v
            titlesMap[id]   = title
        }

        self.movieVectors = vectors
        self.titles       = titlesMap
    }

    func recommend(similarTo movieId: Int, topK: Int = 5) -> [String] {
        guard let target = movieVectors[movieId] else { return [] }
        let targetNorm = sqrt(target.map { $0*$0 }.reduce(0, +))

        let scores = movieVectors.compactMap { (id, vector) -> (String, Double)? in
            guard id != movieId else { return nil }
            let dot  = zip(target, vector).map(*).reduce(0, +)
            let norm = sqrt(vector.map { $0*$0 }.reduce(0, +))
            guard norm > 0 && targetNorm > 0 else { return nil }
            let cos = dot / (norm * targetNorm)
            return (titles[id]!, cos)
        }

        return scores
            .sorted(by: { $0.1 > $1.1 })
            .prefix(topK)
            .map { $0.0 }
    }
}
