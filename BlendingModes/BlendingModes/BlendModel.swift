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
}
