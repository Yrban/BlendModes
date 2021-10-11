//
//  BlendModel.swift
//  BlendingModes
//
//  Created by Developer on 10/1/21.
//

import SwiftUI

class BlendModel: ObservableObject {
    
    public static var shared = BlendModel()
    
    @Published var colors: [Color] = []
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
        colors.append(color)
    }
    
    func changeColor(_ color:Color, at index: Int) {
        colors[index] = color
    }
}

extension BlendModel {
    
    convenience init(colorsQty: Int) {
        self.init()
        let qty = colorsQty.clamped(from: 1, to: 5)
        if colors.count > qty {
            let count = colors.count - qty
            for _ in 1...count {
                colors.removeLast()
            }
        } else if colors.count < qty {
            let count = qty - colors.count
            for _ in 1...count {
                addColor(color: Color.random)
            }
        }
    }
}

