import SwiftUI
import Observation

struct Layer: Identifiable {
    var id = UUID()
    var type: DemoMode

    // Blend settings
    var blendMode: BlendMode = .normal
    var opacity: Double = 1.0
    var colorInvert: Bool = false

    // Circles content — one circle per layer; add another layer for a second circle
    var color: Color = .red

    // Position offset in the canvas (points)
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0

    // Image content — one image per layer; add another layer for a second image
    var imageData: Data? = nil

    // Text content
    var text: String = "Blend"
    var textColor: Color = .white
    var fontSize: Double = 72
}

@Observable
class BlendModel {
    // layers[0] = top of canvas, layers.last = bottom of canvas
    // The background layer is always last; it fills the canvas and is not draggable
    var layers: [Layer]

    init(layers: [Layer]? = nil) {
        if let layers {
            self.layers = layers
        } else {
            var bg = Layer(type: .background)
            bg.color = .gray
            self.layers = [Layer(type: .circles), bg]
        }
    }

    // MARK: - Code Generation

    func codeSnippet() -> String {
        var lines = ["ZStack {"]
        if let bgColor = layers.last(where: { $0.type == .background })?.color {
            lines.append("    \(colorLiteral(bgColor)) // background" + newLine)
        }

        // Split at compositingGroup layers; each group above a CG boundary gets .compositingGroup()
        // Exclude background layers from content segments
        var segments: [(layers: [Layer], needsCG: Bool)] = []
        var current: [Layer] = []
        for layer in layers where layer.type != .background {
            if layer.type == .compositingGroup {
                if !current.isEmpty { segments.append((current, true)); current = [] }
            } else {
                current.append(layer)
            }
        }
        if !current.isEmpty { segments.append((current, false)) }

        var blocks: [[String]] = []
        for segment in segments.reversed() {
            if segment.needsCG {
                var block = ["    ZStack {"]
                for layer in segment.layers.reversed() { block += layerCode(layer, indent: "        ") }
                block += ["    }", "    .compositingGroup()"]
                blocks.append(block)
            } else {
                for layer in segment.layers.reversed() {
                    blocks.append(layerCode(layer, indent: "    "))
                }
            }
        }
        lines += blocks.joined(separator: [""])

        lines.append("}")
        return lines.joined(separator: newLine)
    }

    // MARK: - Private helpers

    private func layerCode(_ layer: Layer, indent: String) -> [String] {
        switch layer.type {
        case .circles:          return circlesCode(layer, indent: indent)
        case .images:           return imagesCode(layer, indent: indent)
        case .text:             return textCode(layer, indent: indent)
        case .compositingGroup: return []
        case .background:       return []
        }
    }

    private func circlesCode(_ layer: Layer, indent: String) -> [String] {
        var lines: [String] = []
        lines.append("\(indent)Circle()")
        lines.append("\(indent)    .fill(\(colorLiteral(layer.color)))")
        lines += modifiers(layer, indent: indent + "    ")
        return lines
    }

    private func imagesCode(_ layer: Layer, indent: String) -> [String] {
        var lines: [String] = []
        lines.append("\(indent)Image(\"myImage\") // replace with your asset name")
        lines.append("\(indent)    .resizable()")
        lines.append("\(indent)    .scaledToFit()")
        lines += modifiers(layer, indent: indent + "    ")
        return lines
    }

    private func textCode(_ layer: Layer, indent: String) -> [String] {
        let t = layer.text.isEmpty ? "Blend" : layer.text
        var lines: [String] = []
        lines.append("\(indent)Text(\"\(t)\")")
        lines.append("\(indent)    .font(.system(size: \(Int(layer.fontSize))))")
        lines.append("\(indent)    .foregroundStyle(\(colorLiteral(layer.textColor)))")
        lines += modifiers(layer, indent: indent + "    ")
        return lines
    }

    private func modifiers(_ layer: Layer, indent: String) -> [String] {
        var lines: [String] = []
        lines.append("\(indent).blendMode(\(layer.blendMode.description))")
        if layer.opacity < 1 { lines.append("\(indent).opacity(\(fmt(layer.opacity)))") }
        if layer.colorInvert  { lines.append("\(indent).colorInvert()") }
        return lines
    }

    private func colorLiteral(_ color: Color) -> String {
        guard let c = color.components else { return "Color.gray" }
        return "Color(red: \(fmt(c.r)), green: \(fmt(c.g)), blue: \(fmt(c.b)))"
    }

    private let newLine: String = "\n"
    
    private func fmt(_ v: Double) -> String { v.formatted(.number.precision(.fractionLength(2))) }
}
