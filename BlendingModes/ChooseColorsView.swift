import SwiftUI

struct ChooseColorsView: View {
    @Environment(BlendModel.self) private var blendModel

    var body: some View {
        @Bindable var model = blendModel

        ForEach(model.colors.indices, id: \.self) { index in
            VStack {
                ColorPicker("Choose a color:", selection: $model.colors[index], supportsOpacity: false)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(colorPickerLabel(index: index))
                    .deleteDisabled(model.colors.count == 1)
                Text(model.colors[index].componentText())
                    .fixedSize()
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .onDelete { indexSet in
            model.colors.remove(atOffsets: indexSet)
        }

        Button {
            withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.3)) {
                model.addColor()
            }
        } label: {
            Label("Add New Color", systemImage: "plus.circle")
        }
        .disabled(model.colors.count > 4)
        .accessibilityLabel("Add New Color")

        VStack {
            ColorPicker("Background color:", selection: $model.background, supportsOpacity: false)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(backgroundPickerLabel)
            Text(model.background.componentText())
                .fixedSize()
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func colorPickerLabel(index: Int) -> String {
        "Change the \((index + 1).ordinalFormatter()) color from \(colorName(for: blendModel.colors[index]))"
    }

    private var backgroundPickerLabel: String {
        "Change the background color from \(colorName(for: blendModel.background))"
    }

    private func colorName(for color: Color) -> String {
        #if canImport(UIKit)
        return UIColor(color).accessibilityName
        #else
        return color.description
        #endif
    }
}

#Preview {
    List {
        ChooseColorsView()
    }
    .environment(BlendModel(colors: [.red, .blue]))
}
