//
//  BlendModeViewModifier.swift
//  BlendingModes
//
//  Created by Developer on 10/5/21.
//

import SwiftUI

struct BlendModeViewModifier: ViewModifier {
    
    var blendMode: BlendMode
    var enabled: Bool
    
    init(_ blendMode: BlendMode, enabled: Bool) {
        self.enabled = enabled
        self.blendMode = blendMode
    }
    
    func body(content: Content) -> some View {
        if enabled {
            content
                .blendMode(blendMode)
        } else {
            content
        }
    }
    
}

extension View {
    func blendMode(_ blendMode: BlendMode, enabled: Bool = true) -> some View {
        self.modifier(BlendModeViewModifier(blendMode, enabled: enabled))
    }
}


