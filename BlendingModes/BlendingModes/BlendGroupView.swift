import SwiftUI

struct BlendGroupView: View {
    @Environment(BlendModel.self) private var blendModel
    let mode: BlendMode

    var body: some View {
        GeometryReader { geo in
            let minDim = min(geo.size.width, geo.size.height)
            let count = blendModel.colors.count
            let offset = count > 1 ? Int(minDim) / (count * 10) : 0

            // Background fills the full GeometryReader area
            blendModel.background

            // Blended circles centered in the view
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

                // Stroke outlines drawn above the blend so they're always visible
                ForEach(blendModel.colors.indices, id: \.self) { index in
                    Circle()
                        .strokeBorder(.black, lineWidth: 2)
                        .offset(x: CGFloat(offset * count), y: CGFloat(offset * count))
                        .rotationEffect(.degrees(360.0 / Double(max(count, 1)) * Double(index)))
                }
            }
            .frame(width: minDim * 0.7, height: minDim * 0.7)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
    }
}

#Preview {
    BlendGroupView(mode: .multiply)
        .frame(width: 300, height: 300)
        .environment(BlendModel(colors: [.red, .blue, .green]))
}
