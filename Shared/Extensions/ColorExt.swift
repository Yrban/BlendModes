import SwiftUI

extension Color {
    var components: (r: Double, g: Double, b: Double, o: Double)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        #if canImport(UIKit)
        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else { return nil }
        #elseif canImport(AppKit)
        guard let converted = NSColor(self).usingColorSpace(.sRGB) else { return nil }
        converted.getRed(&r, green: &g, blue: &b, alpha: &a)
        #endif

        return (Double(r), Double(g), Double(b), Double(a))
    }

    func componentText() -> String {
        guard let c = components else { return "Error" }
        return "Red: \(Int(c.r * 255)), Green: \(Int(c.g * 255)),\nBlue: \(Int(c.b * 255)), Alpha: \(Int(c.o * 255))"
    }

    static var random: Color {
        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}

#if canImport(UIKit)
extension UIColor {
    var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white > 0.5
    }
}
#endif
