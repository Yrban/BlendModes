//
//  GlowViewModifier.swift
//  BlendingModes
//
//  Created by Developer on 10/7/21.
//

import SwiftUI

struct GlowViewModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 30, style: .circular)
                            .stroke(color, lineWidth: 200)
                            .blur(radius: 100)
                            .edgesIgnoringSafeArea([.horizontal, .bottom])
                            .opacity(0.9))
            
    }
}

extension View {
    func glow(with color: Color) -> some View {
        self.modifier(GlowViewModifier(color: color))
    }
}
