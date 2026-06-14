import SwiftUI
import Observation

@Observable
class BlendModel {
    var colors: [Color]
    var background: Color
    var colorInvert: Bool
    var compositingMode: Bool
    var blur: Double
    var opacity: Double

    // Demo mode selection
    var demoMode: DemoMode = .circles

    // Images mode
    var bottomImageData: Data? = nil
    var topImageData: Data? = nil

    // Text mode
    var demoText: String = "Blend"
    var textColor: Color = .white
    var fontSize: Double = 72

    init(colors: [Color] = [.red], background: Color = .gray) {
        self.colors = colors
        self.background = background
        self.colorInvert = false
        self.compositingMode = false
        self.blur = 0
        self.opacity = 1
    }

    func addColor(_ color: Color = .random) {
        colors.append(color)
    }

    func changeColor(_ color: Color, at index: Int) {
        colors[index] = color
    }

    // MARK: - Code Generation

    func codeSnippet(for mode: BlendMode) -> String {
        var lines: [String] = ["ZStack {"]
        lines.append("    \(colorLiteral(background)) // background")

        switch demoMode {
        case .circles:
            lines += circlesCode(mode: mode)
        case .images:
            lines += imagesCode(mode: mode)
        case .text:
            lines += textCode(mode: mode)
        }

        lines.append("}")
        return lines.joined(separator: "\n")
    }

    // MARK: - Private helpers

    private func circlesCode(mode: BlendMode) -> [String] {
        var lines: [String] = []
        let count = max(colors.count, 1)
        // Representative offset using a 200pt canvas
        let offset = count > 1 ? 200.0 / Double(count * 10) : 0.0

        lines.append("    ZStack {")
        for (i, color) in colors.enumerated() {
            let angle = 360.0 / Double(count) * Double(i)
            lines.append("        Circle()")
            lines.append("            .fill(\(colorLiteral(color)))")
            if offset > 0 {
                lines.append("            .offset(x: \(formatted(offset)), y: \(formatted(offset)))")
            }
            if i > 0 {
                lines.append("            .rotationEffect(.degrees(\(formatted(angle))))")
            }
        }
        lines.append("    }")
        lines += blendModifiers(mode: mode, indent: "    ")
        return lines
    }

    private func imagesCode(mode: BlendMode) -> [String] {
        var lines: [String] = []
        lines.append("    // Replace asset names with your images")
        lines.append("    Image(\"baseImage\")")
        lines.append("        .resizable()")
        lines.append("        .scaledToFit()")
        lines.append("    Image(\"blendImage\")")
        lines.append("        .resizable()")
        lines.append("        .scaledToFit()")
        lines += blendModifiers(mode: mode, indent: "    ")
        return lines
    }

    private func textCode(mode: BlendMode) -> [String] {
        let displayText = demoText.isEmpty ? "Blend" : demoText
        var lines: [String] = []
        lines.append("    Text(\"\(displayText)\")")
        lines.append("        .font(.system(size: \(Int(fontSize))))")
        lines.append("        .foregroundStyle(\(colorLiteral(textColor)))")
        lines += blendModifiers(mode: mode, indent: "    ")
        return lines
    }

    private func blendModifiers(mode: BlendMode, indent: String) -> [String] {
        var lines: [String] = []
        lines.append("\(indent).blendMode(\(mode.description))")
        if opacity < 1 {
            lines.append("\(indent).opacity(\(formatted(opacity)))")
        }
        if blur > 0 {
            lines.append("\(indent).blur(radius: \(formatted(blur * 20)))")
        }
        if colorInvert {
            lines.append("\(indent).colorInvert()")
        }
        if compositingMode {
            lines.append("\(indent).compositingGroup()")
        }
        return lines
    }

    private func colorLiteral(_ color: Color) -> String {
        guard let c = color.components else { return "Color.gray" }
        return "Color(red: \(formatted(c.r)), green: \(formatted(c.g)), blue: \(formatted(c.b)))"
    }

    private func formatted(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}
