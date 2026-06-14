import SwiftUI

struct BlendGroupView: View {
    @Environment(BlendModel.self) private var blendModel
    let mode: BlendMode

    var body: some View {
        GeometryReader { geo in
            let minDim = min(geo.size.width, geo.size.height)
            let count = blendModel.colors.count
            let offset = count > 1 ? Int(minDim) / (count * 10) : 0

            blendModel.background

            canvasContent(minDim: minDim, offset: offset, count: count)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
    }

    @ViewBuilder
    private func canvasContent(minDim: CGFloat, offset: Int, count: Int) -> some View {
        if blendModel.demoMode == .circles {
            circlesCanvas(offset: offset, count: count)
                .frame(width: minDim * 0.7, height: minDim * 0.7)
        } else if blendModel.demoMode == .images {
            imagesCanvas()
                .frame(width: minDim, height: minDim)
        } else {
            textCanvas(size: minDim)
                .frame(width: minDim, height: minDim)
        }
    }

    // MARK: - Circles

    @ViewBuilder
    private func circlesCanvas(offset: Int, count: Int) -> some View {
        ZStack {
            ZStack {
                ForEach(Array(zip(blendModel.colors.indices, blendModel.colors)), id: \.1) { index, color in
                    SingleView(color: color, offset: offset, count: count, index: index)
                        .accessibilityLabel("Circle \(index + 1) of \(count), blend mode: \(mode.description)")
                }
            }
            .blendMode(mode)
            .colorInvert(enabled: blendModel.colorInvert)
            .compositingGroup(enabled: blendModel.compositingMode)
            .blur(radius: blendModel.blur * 20)
            .opacity(blendModel.opacity)

            // Stroke outlines are not blended so they stay visible
            ForEach(blendModel.colors.indices, id: \.self) { index in
                Circle()
                    .strokeBorder(.black, lineWidth: 2)
                    .offset(x: CGFloat(offset * count), y: CGFloat(offset * count))
                    .rotationEffect(.degrees(360.0 / Double(max(count, 1)) * Double(index)))
            }
        }
    }

    // MARK: - Images

    @ViewBuilder
    private func imagesCanvas() -> some View {
        // Base layer
        if let data = blendModel.bottomImageData,
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            imagePlaceholder(label: "Base Image", icon: "photo")
        }

        // Blend layer
        ZStack {
            if let data = blendModel.topImageData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                imagePlaceholder(label: "Blend Image", icon: "photo.on.rectangle")
            }
        }
        .blendMode(mode)
        .colorInvert(enabled: blendModel.colorInvert)
        .compositingGroup(enabled: blendModel.compositingMode)
        .blur(radius: blendModel.blur * 20)
        .opacity(blendModel.opacity)
    }

    private func imagePlaceholder(label: String, icon: String) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.secondary.opacity(0.15))
            .overlay {
                VStack(spacing: 8) {
                    Image(systemName: icon)
                        .font(.title2)
                    Text(label)
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
            }
    }

    // MARK: - Text

    @ViewBuilder
    private func textCanvas(size: CGFloat) -> some View {
        ZStack {
            Text(blendModel.demoText.isEmpty ? "Blend" : blendModel.demoText)
                .font(.system(size: blendModel.fontSize))
                .foregroundStyle(blendModel.textColor)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
                .padding(size * 0.05)
        }
        .blendMode(mode)
        .colorInvert(enabled: blendModel.colorInvert)
        .compositingGroup(enabled: blendModel.compositingMode)
        .blur(radius: blendModel.blur * 20)
        .opacity(blendModel.opacity)
    }
}

#Preview {
    BlendGroupView(mode: .multiply)
        .frame(width: 300, height: 300)
        .environment(BlendModel(colors: [.red, .blue, .green]))
}
