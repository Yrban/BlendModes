//
//  ColorExt.swift
//  BlendingModes
//
//  Created by Developer on 10/1/21.
//

import SwiftUI

extension Color: CaseIterable {
    public static var allCases: [Color] {
        [.clear, .red, .orange, .yellow, .green, .blue, .indigo, .purple, .gray, .black, .white, .brown, .cyan, .mint, .pink, .teal]
    }
}

extension Color {

    var components: (r: Double, g: Double, b: Double, o: Double)? {
        let uiColor: UIColor
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        
        if self.description.contains("NamedColor") {
            let lowerBound = self.description.range(of: "name: \"")!.upperBound
            let upperBound = self.description.range(of: "\", bundle")!.lowerBound
            let assetsName = String(self.description[lowerBound..<upperBound])
            
            uiColor = UIColor(named: assetsName)!
        } else {
            uiColor = UIColor(self)
        }

        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &o) else { return nil }
        
        return (Double(r), Double(g), Double(b), Double(o))
    }
    
    func componentText() -> String {
        guard let components = self.components else { return "Error" }
        let r = Int(components.r * 255)
        let g = Int(components.g * 255)
        let b = Int(components.b * 255)
        let o = Int(components.o * 255)
        return "Red: \(r), Green: \(g),\nBlue: \(b), Alpha: \(o)"
    }

    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

extension UIColor {
    var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white > 0.5
    }

}
