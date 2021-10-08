//
//  CompositingGroupViewModifier.swift
//  BlendingModes
//
//  Created by Developer on 10/5/21.
//

import SwiftUI

struct CompositingGroupViewModifier: ViewModifier {
    
    var enabled: Bool
    
    func body(content: Content) -> some View {
        if enabled {
            content
                .compositingGroup()
        } else {
            content
        }
    }
}

extension View {
    func compositingGroup(enabled: Bool) -> some View {
        self.modifier(CompositingGroupViewModifier(enabled: enabled))
    }
}

