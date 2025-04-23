import SwiftUI
import AppIntents

struct ContentView: View {
  // read/write from the same key your intent uses
  @AppStorage("selectedColor") private var storedColorName: String = ColorChoice.red.rawValue

  // still show a status label if you like
  @State private var statusMessage = "Tap a color or ask Siri"

  // compute a Color from the stored name
  private var selectedColor: Color {
    ColorChoice(rawValue: storedColorName)?.swiftUIColor ?? .gray
  }

  var body: some View {
    VStack(spacing: 30) {
      Rectangle()
        .fill(selectedColor)
        .frame(width: 200, height: 200)
        .cornerRadius(20)
        .overlay(Text(statusMessage).foregroundColor(.white).bold())

      HStack(spacing: 15) {
        ForEach(ColorChoice.allCases, id: \.self) { choice in
          Button(choice.rawValue) {
            Task {
              // in-app invocation (still donates + updates UI immediately)
              var intent = ChangeColorIntent()
              intent.color = choice
              do {
                let response = try await intent.perform()
                let name = response.value ?? choice.rawValue
                statusMessage = "Color set to \(name)"
                // `@AppStorage` already saved it for us
              } catch {
                statusMessage = "Error: \(error.localizedDescription)"
              }
            }
          }
          .padding(8)
          .overlay(RoundedRectangle(cornerRadius: 8).stroke())
        }
      }
    }
    .padding()
    // also refresh when coming back from the background
    .onChange(of: UIApplication.shared.applicationState) { _ in
      statusMessage = "Tap a color or ask Siri"
    }
  }
}
