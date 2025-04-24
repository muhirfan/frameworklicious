//
//  ContentView.swift
//  ML Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI
import SwiftData
import CoreML

struct ContentView: View {
    @State private var ageText = ""
    @State private var incomeText = ""
    @State private var resultText = ""

    private let model: WillBuyClassifier_1 = {
        let config = MLModelConfiguration()
        return try! WillBuyClassifier_1(configuration: config)
    }()

    var body: some View {
        VStack(spacing: 24) {
            Text("WillBuy Demo")
                .font(.largeTitle)
                .padding(.top)

            Group {
                TextField("Age", text: $ageText)
                    .keyboardType(.numberPad)
                TextField("Income", text: $incomeText)
                    .keyboardType(.numberPad)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)

            Button("Predict") {
                makePrediction()
            }
            .buttonStyle(.borderedProminent)

            Text(resultText)
                .font(.title2)
                .padding(.top)

            Spacer()
        }
        .padding()
    }

    private func makePrediction() {
        guard
            let age = Double(ageText),
            let income = Double(incomeText)
        else {
            resultText = "⚠️ Enter valid numbers"
            return
        }

        do {
            let input = WillBuyClassifier_1Input(age: Int64(age), income: Int64(income))
            let output = try model.prediction(input: input)
            resultText = (output.willBuy == "yes")
                ? "✅ Likely to buy"
                : "❌ Unlikely to buy"
        } catch {
            resultText = "❌ Error: \(error.localizedDescription)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
