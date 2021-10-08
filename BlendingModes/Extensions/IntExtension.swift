//
//  IntExtension.swift
//  BlendingModes
//
//  Created by Developer on 10/8/21.
//

import Foundation

extension Int {
    func ordinalFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        guard let ordinalString = formatter.string(from: self as NSNumber) else { return "" }
        return ordinalString
    }
}
