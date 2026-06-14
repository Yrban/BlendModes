import SwiftUI

enum DemoMode: String, CaseIterable {
    case circles = "Circles"
    case images = "Images"
    case text = "Text"

    var systemImage: String {
        switch self {
        case .circles: "circle.grid.3x3"
        case .images: "photo.on.rectangle"
        case .text: "textformat"
        }
    }
}
