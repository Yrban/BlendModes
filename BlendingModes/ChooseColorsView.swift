import SwiftUI

struct ChooseColorsView: View {
    @Binding var layer: Layer

    var body: some View {
        ColorPicker("Circle Color", selection: $layer.color, supportsOpacity: false)
    }
}

#Preview {
    @Previewable @State var layer = Layer(type: .circles)
    List { ChooseColorsView(layer: $layer) }
}
