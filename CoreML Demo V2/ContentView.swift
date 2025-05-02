//
//  ContentView.swift
//  CoreML Demo V2
//
//  Created by Kaushik Manian on 2/5/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    let cfModel: MovieRecommender = {
        do {
            return try MovieRecommender(configuration: MLModelConfiguration())
        } catch {
            fatalError("Failed to load MovieRecommender.mlmodel: \(error)")
        }
    }()

    let cbModel: ContentBasedRecommender = {
        let url = Bundle.main.url(forResource: "movies", withExtension: "csv")!
        return try! ContentBasedRecommender(moviesCSV: url)
    }()

    // MARK: – Load movies.csv into [movieId: title] (same as content-based)
    private let movies: [Int:String] = {
        let url = Bundle.main.url(forResource: "movies", withExtension: "csv")!
        let text = try! String(contentsOf: url, encoding: .utf8)
        var map = [Int:String]()

        for line in text.components(separatedBy: "\n").dropFirst() {
            let cols = line.components(separatedBy: ",")
            guard cols.count >= 3, let id = Int(cols[0]) else { continue }
            let title = cols[1]
            map[id] = title
        }

        return map
    }()

    @State private var cfRecs = [String]()
    @State private var cbRecs = [String]()

    var body: some View {
        NavigationView {
            List {
                Section("Collaborative (user 1)") {
                    if cfRecs.isEmpty {
                        Text(" No collaborative recommendations found.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(cfRecs.indices, id: \.self) { i in
                            Text("\(i + 1). \(cfRecs[i])")
                        }
                    }
                }

                Section("Content-Based (movie 1)") {
                    ForEach(cbRecs.indices, id: \.self) { i in
                        Text("\(i + 1). \(cbRecs[i])")
                    }
                }
            }
            .navigationTitle("Movie Recommendations")
            .task {
                await loadCollaborative()
                loadContentBased()
            }
        }
    }

    private func loadCollaborative() async {
        guard let url = Bundle.main.url(forResource: "ratings", withExtension: "csv") else {
            print(" Couldn't find ratings.csv")
            return
        }

        let text = (try? String(contentsOf: url, encoding: .utf8)) ?? ""
        var interactions = [Int64: Double]()

        for line in text.split(separator: "\n").dropFirst() {
            let parts = line.split(separator: ",")
            guard parts.count >= 3,
                  let u = Double(parts[0]), u == 1,
                  let m = Int(parts[1]),
                  let r = Double(parts[2]) else { continue }
            interactions[Int64(m)] = r
        }

        print(" User 1 interactions:", interactions)

        let allMovieIDs = movies.keys.map { Int64($0) }

        do {
            let output = try cfModel.prediction(
                items: interactions,
                k: 5,
                restrict_: allMovieIDs,
                exclude: Array(interactions.keys)
            )

            print("CF model output:", output.recommendations)

            cfRecs = output.recommendations.map { id in
                let intId = Int(id)
                return movies[intId]?.replacingOccurrences(of: "\"", with: "") ?? "Movie ID \(id)"
            }

        } catch {
            print(" CF prediction failed: \(error)")
            cfRecs = ["Error: CF model failed."]
        }
    }

    private func loadContentBased() {
        cbRecs = cbModel.recommend(similarTo: 1, topK: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
