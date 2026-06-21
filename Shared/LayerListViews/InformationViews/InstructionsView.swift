import SwiftUI

struct InstructionsView: View {
    var body: some View {
        List {
            Section("The Canvas") {
                InstructionRow(icon: "rectangle.fill",
                               title: "Full-screen canvas",
                               detail: "The canvas fills the entire screen behind the layer panel. Drag the panel's handle to collapse it and see more of your composition.")
                InstructionRow(icon: "hand.draw",
                               title: "Drag layers",
                               detail: "Touch and drag any layer directly on the canvas to reposition it. Layers can overlap freely — that's how blend modes interact.")
                InstructionRow(icon: "arrow.counterclockwise",
                               title: "Recenter all",
                               detail: "Tap the ↺ button in the Layers header to snap every layer back to the center of the canvas at once.")
            }

            Section("Managing Layers") {
                InstructionRow(icon: "plus.circle.fill",
                               title: "Add a layer",
                               detail: "Tap + to add a Color Circle, Image, Text, Compositing Group, or Background layer. The + menu also contains Presets — pre-configured starting points that demonstrate common blend mode scenarios.")
                InstructionRow(icon: "rectangle.stack",
                               title: "Layer order",
                               detail: "Layers at the top of the list sit on top of the canvas. Layers at the bottom sit behind. The Background layer is always last and fills the canvas entirely.")
                InstructionRow(icon: "arrow.up.arrow.down",
                               title: "Reorder layers",
                               detail: "Tap Edit in the Layers header. Grab the handle (≡) on the right side of any row and drag it to a new position. Tap Done when finished.")
                InstructionRow(icon: "trash",
                               title: "Delete a layer",
                               detail: "Swipe left on any layer row and tap Delete. The Background layer can be deleted and re-added from the + menu.")
            }

            Section("Editing a Layer") {
                InstructionRow(icon: "chevron.down",
                               title: "Expand a row",
                               detail: "Tap a layer row to expand it. You'll find the blend mode picker, content controls (color, image, or text), opacity slider, and color invert toggle.")
                InstructionRow(icon: "circle.grid.3x3",
                               title: "Blend mode picker",
                               detail: "The blend mode picker groups all 21 modes by family — Normal, Darken, Lighten, Contrast, Inversion, Component, and Compositing — so you can explore related modes together.")
                InstructionRow(icon: "scope",
                               title: "Recenter a single layer",
                               detail: "If a layer has been dragged off-center, a Recenter on Canvas button appears at the bottom of its expanded row. It only appears when the layer is actually offset.")
            }

            Section("Layer Types") {
                InstructionRow(icon: "circle.grid.3x3",
                               title: "Color Circle",
                               detail: "A solid circle in a color you choose. The simplest way to see how blend modes interact — overlap two circles and change their modes.")
                InstructionRow(icon: "photo.on.rectangle",
                               title: "Image",
                               detail: "Tap Select Image to pick a photo from your library. Tap Change Image to swap it. Applying blend modes to photographs reveals more complex color interactions than solid shapes alone.")
                InstructionRow(icon: "textformat",
                               title: "Text",
                               detail: "Enter any text in the layer row header. Set the color in the expanded controls. Text layers are useful for seeing how blend modes handle high-contrast edges and partial transparency.")
                InstructionRow(icon: "square.3.layers.3d",
                               title: "Compositing Group",
                               detail: "A boundary marker, not a visual layer. Layers above a Compositing Group blend among themselves first, producing a single flattened result, which then blends with layers below. Requires at least two other layers to be available.")
                InstructionRow(icon: "rectangle.fill",
                               title: "Background",
                               detail: "A solid color that fills the entire canvas behind all other layers. Only one Background can exist at a time. Tap its color swatch to change the color. White and black backgrounds produce very different blend mode results.")
            }

            Section("Generated Code") {
                InstructionRow(icon: "curlybraces",
                               title: "Copy SwiftUI code",
                               detail: "Scroll to the Generated Code section at the bottom of the layer panel. It produces ready-to-paste SwiftUI that reproduces the current canvas, including blend modes, opacity, compositing groups, and colors.")
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
