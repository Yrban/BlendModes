import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    let title: String
    var range: ClosedRange<Double> = 0...1
    var displayText: String? = nil

    private var resolvedDisplay: String {
        displayText ?? "\(Int(value * 100))%"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):  \(resolvedDisplay)")
                .font(.callout)
                .foregroundStyle(.secondary)
            Slider(value: $value, in: range)
                .tint(.blue)
                .accessibilityLabel("\(title) slider")
                .accessibilityValue(resolvedDisplay)
        }
    }
}

#Preview {
    @Previewable @State var value = 0.5
    SliderView(value: $value, title: "Opacity")
}
