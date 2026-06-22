import SwiftUI

struct InstructionsView: View {
    var body: some View {
        List {
            Section("The Canvas") {
                InstructionRow(icon: "rectangle.fill",
                               title: "Full-screen canvas",
                               detail: "The canvas fills the screen behind the layer panel. On iOS, drag the panel's handle to collapse it and see more of your composition.")
                InstructionRow(icon: "hand.draw",
                               title: "Drag layers",
                               detail: "Drag any layer directly on the canvas to reposition it. Layers can overlap freely — that's how blend modes interact.")
                InstructionRow(icon: "arrow.counterclockwise",
                               title: "Recenter all",
                               detail: "Tap or click the ↺ button in the Layers header to snap every layer back to the center of the canvas at once.")
            }

            Section("Managing Layers") {
                InstructionRow(icon: "plus.circle.fill",
                               title: "Add a layer",
                               detail: "Tap or click + to add a Color Circle, Image, Text, Compositing Group, or Background layer. The + menu also contains Presets — pre-configured starting points that demonstrate common blend mode scenarios.")
                InstructionRow(icon: "rectangle.stack",
                               title: "Layer order",
                               detail: "Layers at the top of the list sit on top of the canvas. Layers at the bottom sit behind. The Background layer is always last and fills the canvas entirely.")
                InstructionRow(icon: "arrow.up.arrow.down",
                               title: "Reorder layers",
                               detail: "On iOS, tap Edit in the Layers header, then grab the ≡ handle on the right of any row and drag it to a new position. On macOS, drag the ≡ handle directly without entering Edit mode.")
                InstructionRow(icon: "trash",
                               title: "Delete a layer",
                               detail: "On iOS, swipe left on a row and tap Delete. On macOS, right-click a row and choose Delete, or select it and press the Delete key. The Background layer can be deleted and re-added from the + menu.")
            }

            Section("Editing a Layer") {
                InstructionRow(icon: "chevron.down",
                               title: "Expand a row",
                               detail: "Tap or click a layer row to expand its controls. Tap or click again to collapse.")
                InstructionRow(icon: "circle.grid.3x3",
                               title: "Blend mode picker",
                               detail: "The blend mode picker groups all 21 modes by family — Normal, Darken, Lighten, Contrast, Inversion, Component, and Compositing — so you can explore related modes together. Changes update the canvas immediately.")
                InstructionRow(icon: "slider.horizontal.3",
                               title: "Opacity",
                               detail: "The opacity slider controls the layer's transparency from 0 (invisible) to 1 (fully opaque). When opacity is applied inside a Compositing Group, it fades the entire group as a unit rather than making each layer individually semi-transparent.")
                InstructionRow(icon: "circle.lefthalf.striped.horizontal.inverse",
                               title: "Color Invert",
                               detail: "The Color Invert toggle applies .colorInvert() to the layer, flipping each color to its complementary. Inversion and blend modes compound — enabling both produces effects neither achieves alone.")
                InstructionRow(icon: "paintpalette",
                               title: "Layer-specific controls",
                               detail: "Color Circle and Background layers show a color picker. Text layers show a text field, font size slider, and text color picker. Image layers show a button to select or swap a photo from your library.")
                InstructionRow(icon: "scope",
                               title: "Recenter a single layer",
                               detail: "If a layer has been dragged off-center, a Recenter on Canvas button appears at the bottom of its expanded row. It only appears when the layer is actually offset.")
            }

            Section("Layer Types") {
                InstructionRow(icon: "circle.fill",
                               title: "Color Circle",
                               detail: "A solid circle in a color you choose. The simplest way to see how blend modes interact — overlap two circles and change their modes.")
                InstructionRow(icon: "photo.on.rectangle",
                               title: "Image",
                               detail: "Select a photo from your library. Applying blend modes to photographs reveals more complex color interactions than solid shapes alone.")
                InstructionRow(icon: "textformat",
                               title: "Text",
                               detail: "Enter any text in the layer row. Set the color in the expanded controls. Text layers are useful for seeing how blend modes handle high-contrast edges and partial transparency.")
                InstructionRow(icon: "square.3.layers.3d",
                               title: "Compositing Group",
                               detail: "A boundary marker, not a visual layer. Layers above a Compositing Group blend among themselves first, producing a single flattened result, which then blends with layers below. Requires at least two other layers.")
                InstructionRow(icon: "rectangle.fill",
                               title: "Background",
                               detail: "A solid color that fills the entire canvas behind all other layers. Only one Background can exist at a time. White and black backgrounds produce very different blend mode results.")
            }

            Section("Generated Code") {
                InstructionRow(icon: "curlybraces",
                               title: "What it shows",
                               detail: "The Generated Code panel at the bottom of the layers sidebar produces ready-to-paste SwiftUI that reproduces the current canvas — including layer types, colors, blend modes, opacity, color invert, and compositing groups.")
                InstructionRow(icon: "doc.on.clipboard",
                               title: "Copy the code",
                               detail: "Tap or click Copy Code to place the generated SwiftUI on the clipboard. Paste it directly into Xcode. The code uses standard SwiftUI modifiers and requires no additional dependencies.")
            }
        }
        .navigationTitle("How to Use")
    }
}

private struct InstructionRow: View {
    let icon: String
    let title: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Label(title, systemImage: icon)
                .font(.headline)
            Text(detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        InstructionsView()
    }
}
