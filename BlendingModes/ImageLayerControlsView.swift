import SwiftUI
import PhotosUI

struct ImageLayerControlsView: View {
    @Binding var layer: Layer
    @State private var pickerItem: PhotosPickerItem? = nil

    var body: some View {
        PhotosPicker(selection: $pickerItem, matching: .images) {
            HStack {
                Label(
                    layer.imageData == nil ? "Select Image" : "Change Image",
                    systemImage: "photo"
                )
                Spacer()
                if layer.imageData != nil {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
        }
        .onChange(of: pickerItem) { _, item in
            Task {
                if let data = try? await item?.loadTransferable(type: Data.self) {
                    await MainActor.run { layer.imageData = data }
                }
            }
        }


    }
}

#Preview {
    @Previewable @State var layer = Layer(type: .images)
    List { ImageLayerControlsView(layer: $layer) }
}
