import SwiftUI

struct AdjustModeView: View {
    @Environment(BlendModel.self) private var blendModel

    var body: some View {
        @Bindable var model = blendModel

        Toggle("Color Invert", isOn: $model.colorInvert)
            .accessibilityLabel("color invert")
            .accessibilityRemoveTraits(.isButton)
            .accessibilityValue(blendModel.colorInvert ? "is on" : "is off")

        Toggle("Compositing Mode", isOn: $model.compositingMode)
            .accessibilityLabel("compositing mode")
            .accessibilityValue(blendModel.compositingMode ? "is on" : "is off")
            .accessibilityRemoveTraits(.isButton)

        SliderView(value: $model.opacity, title: "Opacity")
        SliderView(value: $model.blur, title: "Blur")
    }
}

#Preview {
    List {
        AdjustModeView()
    }
    .listStyle(.plain)
    .environment(BlendModel())
}
