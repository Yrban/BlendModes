//
//  BlendModel.swift
//  BlendingModes
//
//  Created by Developer on 10/1/21.
//

import SwiftUI
import Collections

class BlendModel: ObservableObject {
    
    public static var shared = BlendModel()
        
    @Published var colors: [ColorInfo] = []
    @Published var background: Color
    @Published var colorInvert: Bool
    @Published var compositingMode: Bool
    @Published var blur: Double
    @Published var opacity: Double
    
    init() {
        background = .gray
        colorInvert = false
        compositingMode = false
        blur = 0
        opacity = 1
        
        addColor(color: .red)
    }
    
    func addColor(color: Color) {
        colors.append(ColorInfo(color: color))
    }
    
    func changeColor(_ color:Color, at index: Int) {
        colors[index].color = color
    }
}

struct ColorInfo: Identifiable, Hashable {
    var id = UUID()
    var color: Color = .clear
    var blend = false
    var invert = false
    var compositing = false
}

extension BlendModel {

    convenience init(colorsQty: Int) {
        self.init()
        if colors.count > colorsQty {
            let count = colors.count - colorsQty
            for _ in 1...count {
                colors.removeLast()
            }
        } else if colors.count < colorsQty {
            let count = colorsQty - colors.count
            for _ in 1...count {
            addColor(color: Color.random)
        }
        }
    }
}
