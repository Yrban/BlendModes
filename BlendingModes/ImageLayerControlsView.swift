import SwiftUI
import PhotosUI

struct ImageLayerControlsView: View {
    @Environment(BlendModel.self) private var blendModel
    @State private var bottomPickerItem: PhotosPickerItem? = nil
    @State private var topPickerItem: PhotosPickerItem? = nil

    var body: some View {
        @Bindable var model = blendModel

        PhotosPicker(selection: $bottomPickerItem, matching: .images) {
            HStack {
                Label("Base Image", systemImage: "photo")
                Spacer()
                if model.bottomImageData != nil {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
        }
        .onChange(of: bottomPickerItem) { _, item in
            Task {
                if let data = try? await item?.loadTransferable(type: Data.self) {
                    await MainActor.run { model.bottomImageData = data }
                }
            }
        }

        PhotosPicker(selection: $topPickerItem, matching: .images) {
            HStack {
                Label("Blend Image", systemImage: "photo.on.rectangle")
                Spacer()
                if model.topImageData != nil {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
        }
        .onChange(of: topPickerItem) { _, item in
            Task {
                if let data = try? await item?.loadTransferable(type: Data.self) {
                    await MainActor.run { model.topImageData = data }
                }
            }
        }

        if model.bottomImageData != nil || model.topImageData != nil {
            Button(role: .destructive) {
                model.bottomImageData = nil
                model.topImageData = nil
                bottomPickerItem = nil
                topPickerItem = nil
            } label: {
                Label("Clear Images", systemImage: "trash")
            }
        }
    }
}

#Preview {
    List { ImageLayerControlsView() }
        .environment(BlendModel())
}
