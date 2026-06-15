import SwiftUI

enum DemoMode: String, CaseIterable {
    case circles = "Color Circle"
    case images = "Image"
    case text = "Text"
    case compositingGroup = "Compositing Group"
    case background = "Background"

    var systemImage: String {
        switch self {
        case .circles: "circle.grid.3x3"
        case .images: "photo.on.rectangle"
        case .text: "textformat"
        case .compositingGroup: "square.3.layers.3d"
        case .background: "rectangle.fill"
        }
    }
}
