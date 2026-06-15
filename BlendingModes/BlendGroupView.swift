import SwiftUI

struct BlendGroupView: View {
    @Environment(BlendModel.self) private var blendModel
    @State private var dragStartOffsets: [UUID: CGSize] = [:]

    var body: some View {
        GeometryReader { geo in
            let minDim = min(geo.size.width, geo.size.height)
            let segments = buildSegments()

            let bgColor = blendModel.layers.last(where: { $0.type == .background })?.color ?? Color.gray
            ZStack {
                bgColor
                    .ignoresSafeArea()

                // Render segments bottom-to-top; each segment above a CG boundary gets .compositingGroup()
                ForEach(Array(segments.enumerated()), id: \.offset) { _, segment in
                    ZStack {
                        ForEach(segment.indices.reversed(), id: \.self) { index in
                            let layer = blendModel.layers[index]
                            canvasView(layer: layer, minDim: minDim)
                                .offset(x: layer.xOffset, y: layer.yOffset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            if dragStartOffsets[layer.id] == nil {
                                                dragStartOffsets[layer.id] = CGSize(
                                                    width: layer.xOffset, height: layer.yOffset
                                                )
                                            }
                                            let start = dragStartOffsets[layer.id]!
                                            blendModel.layers[index].xOffset = start.width + value.translation.width
                                            blendModel.layers[index].yOffset = start.height + value.translation.height
                                        }
                                        .onEnded { _ in
                                            dragStartOffsets[layer.id] = nil
                                        }
                                )
                        }
                    }
                    .compositingGroup(enabled: segment.needsCompositingGroup)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    // MARK: - Segment building

    private struct LayerSegment {
        let indices: [Int]
        let needsCompositingGroup: Bool
    }

    /// Splits layers (top→bottom) at each compositingGroup layer.
    /// Layers above a CG boundary are grouped and will receive .compositingGroup().
    private func buildSegments() -> [LayerSegment] {
        var segments: [LayerSegment] = []
        var current: [Int] = []
        for index in blendModel.layers.indices {
            let type = blendModel.layers[index].type
            if type == .background {
                // Background rendered separately as full-bleed canvas fill — skip here
            } else if type == .compositingGroup {
                if !current.isEmpty {
                    segments.append(LayerSegment(indices: current, needsCompositingGroup: true))
                    current = []
                }
            } else {
                current.append(index)
            }
        }
        if !current.isEmpty {
            segments.append(LayerSegment(indices: current, needsCompositingGroup: false))
        }
        return segments
    }

    // MARK: - Layer rendering

    @ViewBuilder
    private func canvasView(layer: Layer, minDim: CGFloat) -> some View {
        switch layer.type {
        case .circles:
            circlesCanvas(layer: layer)
                .frame(width: minDim * 0.7, height: minDim * 0.7)
        case .images:
            imagesCanvas(layer: layer)
                .frame(width: minDim, height: minDim)
        case .text:
            textCanvas(layer: layer, size: minDim)
                .frame(width: minDim, height: minDim)
        case .compositingGroup, .background:
            EmptyView()
        }
    }

    // MARK: - Circles

    @ViewBuilder
    private func circlesCanvas(layer: Layer) -> some View {
        Circle()
            .fill(layer.color)
            .blendMode(layer.blendMode)
            .colorInvert(enabled: layer.colorInvert)
            .blur(radius: layer.blur * 20)
            .opacity(layer.opacity)
    }

    // MARK: - Image

    @ViewBuilder
    private func imagesCanvas(layer: Layer) -> some View {
        ZStack {
            if let data = layer.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.secondary.opacity(0.15))
                    .overlay {
                        VStack(spacing: 8) {
                            Image(systemName: "photo").font(.title2)
                            Text("Tap to select image").font(.caption)
                        }
                        .foregroundStyle(.secondary)
                    }
            }
        }
        .blendMode(layer.blendMode)
        .colorInvert(enabled: layer.colorInvert)
        .blur(radius: layer.blur * 20)
        .opacity(layer.opacity)
    }

    // MARK: - Text

    @ViewBuilder
    private func textCanvas(layer: Layer, size: CGFloat) -> some View {
        ZStack {
            Text(layer.text.isEmpty ? "Blend" : layer.text)
                .font(.system(size: layer.fontSize))
                .foregroundStyle(layer.textColor)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
                .padding(size * 0.05)
        }
        .blendMode(layer.blendMode)
        .colorInvert(enabled: layer.colorInvert)
        .blur(radius: layer.blur * 20)
        .opacity(layer.opacity)
    }
}

#Preview {
    BlendGroupView()
        .frame(width: 300, height: 300)
        .environment(BlendModel())
}
