import SwiftUI
import CoreML
import Charts

struct ContentView: View {
    @State private var ageText = ""
    @State private var incomeText = ""
    @State private var resultText = ""

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
            (22, 30000), (25, 45000), (47, 85000), (52, 95000),
            (46, 50000), (23, 48000), (39, 60000), (28, 75000),
            (33, 66000), (41, 80000)
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
                    Text("Enter a customer's age and annual income, then tap Predict to see if they are likely to buy.")
                }

                Section(header: Text("Visualization of Training Data")) {
                    Chart(chartData) { point in
                        PointMark(
                            x: .value("Age", point.age),
                            y: .value("Income", point.income)
                        )
                        .symbol(by: .value("WillBuy", point.willBuy))
                        .foregroundStyle(by: .value("WillBuy", point.willBuy))
                        .symbolSize(100)
                    }
                    .chartXAxisLabel("Age")
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
                    Button("Predict Purchase Likelihood") {
                        makePrediction()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                Section(header: Text("Result")) {
                    Text(resultText)
                        .font(.title2)
                        .foregroundColor(resultText.contains("✅") ? .green : .red)
                }

                Section(header: Text("How It Works").font(.headline)) {
                    Text("We trained a small model with examples of age & income labeled as 'yes' or 'no'.")
                    Text("When you enter new values, the model compares them to those examples.")
                    Text("If your inputs look more like past 'yes' cases, it shows ✅ Likely to buy.")
                    Text("If they look more like past 'no' cases, it shows ❌ Unlikely to buy.")
                    Text("Points on the chart use the same examples, so you can see where each label falls.")
                    Text("For instance, ages 25–46 with incomes of 45k–66k were often 'no', so age 35, income 62k is ❌.")
                }
            }
            .navigationTitle("WillBuy Predictor")
        }
    }

    private func makePrediction() {
        guard let age = Double(ageText), let income = Double(incomeText) else {
            resultText = "⚠️ Please enter valid numbers."
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
