//
//  ComparableExt.swift
//  BlendingModes
//
//  Created by Developer on 10/8/21.
//

import Foundation

extension Comparable {
    func clamped(from: Self, to: Self)  ->  Self {
        var clamp = self
        if clamp < from {
            clamp = from
        }
        
        if clamp > to {
            clamp = to
        }
        
        return clamp
    }
}
