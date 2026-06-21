import SwiftUI

struct TextLayerControlsView: View {
    @Binding var layer: Layer

    var body: some View {
        ColorPicker("Text Color", selection: $layer.textColor, supportsOpacity: false)

        SliderView(value: $layer.fontSize, title: "Font Size", range: 20...200, displayText: "\(Int(layer.fontSize))pt")
    }
}

#Preview {
    @Previewable @State var layer = Layer(type: .text)
    List { TextLayerControlsView(layer: $layer) }
}
