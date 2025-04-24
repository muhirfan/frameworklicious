import SwiftUI
import CoreML
import Charts

struct ContentView: View {
    @State private var ageText = ""
    @State private var incomeText = ""
    @State private var resultText = ""

    // Load Core ML model
    private let model: WillBuyClassifier_2 = {
        let config = MLModelConfiguration()
        return try! WillBuyClassifier_2(configuration: config)
    }()

    struct ChartDataPoint: Identifiable {
        let id = UUID()
        let age: Double
        let income: Double
        let willBuy: String
    }

    private var chartData: [ChartDataPoint] {
        let samples: [(age: Double, income: Double)] = [
            (22, 30000),
            (25, 45000),
            (47, 85000),
            (52, 95000),
            (46, 50000),
            (23, 48000),
            (39, 60000),
            (28, 75000),
            (33, 66000),
            (41, 80000)
        ]
        return samples.map { sample in
            let input = WillBuyClassifier_2Input(age: Int64(sample.age), income: Int64(sample.income))
            let prediction = (try? model.prediction(input: input).willBuy) ?? "?"
            return ChartDataPoint(age: sample.age, income: sample.income, willBuy: prediction)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("About the WillBuy Predictor").font(.headline)) {
                    Text("Estimates purchase likelihood based on age & yearly income. Samples are plotted below.")
                }

                Section(header: Text("Visualization")) {
                    Chart(chartData) { point in
                        PointMark(
                            x: .value("Age", point.age),
                            y: .value("Income", point.income)
                        )
                        .symbol(by: .value("WillBuy", point.willBuy))
                        .foregroundStyle(by: .value("WillBuy", point.willBuy))
                        .symbolSize(100)
                    }
                    .chartXAxisLabel("Age (years)")
                    .chartYAxisLabel("Income")
                    .chartLegend(position: .bottom)
                    .frame(height: 250)
                }

                Section(header: Text("Customer Details")) {
                    TextField("Age (years)", text: $ageText)
                        .keyboardType(.numberPad)
                    TextField("Income", text: $incomeText)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button(action: makePrediction) {
                        Text("Predict Purchase Likelihood")
                            .frame(maxWidth: .infinity)
                    }
                }

                Section(header: Text("Result")) {
                    Text(resultText)
                        .font(.title2)
                        .foregroundColor(resultText.contains("✅") ? .green : .red)
                }
            }
            .navigationTitle("WillBuy Predictor")
        }
    }

    private func makePrediction() {
        guard let age = Double(ageText),
              let income = Double(incomeText) else {
            resultText = "⚠️ Please enter valid numbers for both fields."
            return
        }

        do {
            let input = WillBuyClassifier_2Input(age: Int64(age), income: Int64(income))
            let output = try model.prediction(input: input)
            resultText = (output.willBuy == "yes") ? "✅ Likely to buy" : "❌ Unlikely to buy"
        } catch {
            resultText = "❌ Prediction error: \(error.localizedDescription)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
