import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    let title: String

    var body: some View {
        VStack {
            Text(title)
            Text("\((value * 100).formatted(.number.precision(.fractionLength(2))))%")
                .accessibilityHidden(true)
            HStack {
                Image(systemName: "minus")
                    .accessibilityHidden(true)
                Slider(value: $value, in: 0...1)
                    .accessibilityLabel("\(title) slider")
                    .accessibilityValue("\(value.formatted(.percent))")
                Image(systemName: "plus")
                    .accessibilityHidden(true)
            }
            .tint(.blue)
        }
    }
}

#Preview {
    @Previewable @State var value = 0.5
    SliderView(value: $value, title: "Opacity")
}
