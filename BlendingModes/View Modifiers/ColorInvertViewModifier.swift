//
//  ColorInvertViewModifier.swift
//  BlendingModes
//
//  Created by Developer on 10/5/21.
//

import SwiftUI

struct ColorInvertViewModifier: ViewModifier {
    
    var enabled: Bool
    
    func body(content: Content) -> some View {
        if enabled {
            content
                .colorInvert()
        } else {
            content
        }
    }
}

extension View {
    func colorInvert(enabled: Bool) -> some View {
        self.modifier(ColorInvertViewModifier(enabled: enabled))
    }
}


