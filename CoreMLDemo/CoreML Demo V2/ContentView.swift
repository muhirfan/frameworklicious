//
//  ContentView.swift
//  CoreML Demo V2
//
//  Created by Kaushik Manian on 2/5/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    // MARK: – Models

    /// CF model from Create ML
    let cfModel: MovieRecommender = {
        do {
            return try MovieRecommender(configuration: .init())
        } catch {
            fatalError("Failed to load CF model: \(error)")
        }
    }()

    /// Our custom content-based recommender
    let cbModel: ContentBasedRecommender = {
        let url = Bundle.main.url(forResource: "movies", withExtension: "csv")!
        return try! ContentBasedRecommender(moviesCSV: url)
    }()

    /// Map movieID → title
    private let movies: [Int: String] = {
        let url  = Bundle.main.url(forResource: "movies", withExtension: "csv")!
        let text = try! String(contentsOf: url, encoding: .utf8)
        var map  = [Int: String]()
        for line in text.components(separatedBy: "\n").dropFirst() {
            let parts = line.components(separatedBy: ",")
            guard parts.count >= 3, let id = Int(parts[0]) else { continue }
            map[id] = parts[1]
        }
        return map
    }()

    // MARK: – State

    @State private var cfRecs      = [String]()
    @State private var userRatings = [(String, Double)]()
    @State private var cbRecs      = [String]()
    @State private var cbScores    = [(String, Double)]()

    var body: some View {
        NavigationView {
            List {
                // — Collaborative Results —
                Section("Collaborative (User 1)") {
                    if cfRecs.isEmpty {
                        Text("Loading collaborative recommendations…")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(cfRecs.indices, id: \.self) { i in
                            Text("\(i + 1). \(cfRecs[i])")
                        }
                    }
                }

                // — Content-Based Results —
                Section("Content-Based (Movie 1)") {
                    if cbRecs.isEmpty {
                        Text("Loading content-based recommendations…")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(cbRecs.indices, id: \.self) { i in
                            Text("\(i + 1). \(cbRecs[i])")
                        }
                    }
                }

                // — Explanation: Collaborative Filtering —
                Section("How Collaborative Filtering Works") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("1. Take User 1’s observed ratings as training data.")
                        Text("2. CF model learns low-dimensional embeddings for users & movies.")
                        Text("3. To recommend: compute dot-product between User 1’s vector and every movie vector.")
                        Text("4. Higher dot-product → higher predicted affinity. Pick top K unseen movies.")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }

                // — Explanation: Content-Based Filtering —
                Section("How Content-Based Filtering Works") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("1. Build a binary ’genre’ vector for each movie (one-hot encoding).")
                        Text("2. Pick a target movie (Movie 1) and retrieve its vector g₁.")
                        Text("3. For each other movie, compute cosine:")
                        Text("   cos(g₁, gᵢ) = (g₁·gᵢ) / (‖g₁‖·‖gᵢ‖).")
                        Text("4. Sort by descending cosine score; top K are most ’similar’ by genre.")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Movie Recommendations")
            .task {
                await loadCollaborative()
                loadContentBased()
            }
        }
    }

    // MARK: – Data Loading

    /// Load User 1’s ratings and CF recs
    private func loadCollaborative() async {
        guard let url  = Bundle.main.url(forResource: "ratings", withExtension: "csv"),
              let text = try? String(contentsOf: url, encoding: .utf8)
        else { return }

        var interactions = [Int64: Double]()
        for line in text.split(separator: "\n").dropFirst() {
            let parts = line.split(separator: ",")
            guard parts.count >= 3,
                  let u = Double(parts[0]), u == 1,
                  let m = Int64(parts[1]),
                  let r = Double(parts[2])
            else { continue }
            interactions[m] = r
        }

        // Optionally inspect how the raw data looks:
        // print("User 1 ratings:", interactions)

        // Generate top-5 collaborative recommendations
        let allIDs = movies.keys.map { Int64($0) }
        do {
            let out = try cfModel.prediction(
                items: interactions,
                k: 5,
                restrict_: allIDs,
                exclude: Array(interactions.keys)
            )
            cfRecs = out.recommendations.compactMap {
                movies[Int($0)]?.trimmingCharacters(in: .init(charactersIn: "\""))
            }
        } catch {
            cfRecs = ["Error loading CF model"]
        }
    }

    /// Load CB similarity scores and recommendations
    private func loadContentBased() {
        cbScores = cbModel.similarityScores(similarTo: 1, topK: 5)
        cbRecs   = cbScores.map { $0.0 }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
