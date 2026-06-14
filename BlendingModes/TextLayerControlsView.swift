import SwiftUI

struct TextLayerControlsView: View {
    @Environment(BlendModel.self) private var blendModel

    var body: some View {
        @Bindable var model = blendModel

        HStack {
            Text("Text")
                .foregroundStyle(.secondary)
            Spacer()
            TextField("Text to blend", text: $model.demoText)
                .multilineTextAlignment(.trailing)
        }

        ColorPicker("Text Color", selection: $model.textColor, supportsOpacity: false)

        VStack(alignment: .leading) {
            Text("Font Size: \(Int(model.fontSize))pt")
                .foregroundStyle(.secondary)
                .font(.caption)
            Slider(value: $model.fontSize, in: 20...200, step: 4)
                .tint(.blue)
        }
    }
}

#Preview {
    List { TextLayerControlsView() }
        .environment(BlendModel())
}
