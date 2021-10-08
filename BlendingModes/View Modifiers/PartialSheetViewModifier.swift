//
//  PartialSheet.swift
//
//  Created by AlelinApps on 9/27/21.
//  License: MIT License

import SwiftUI

struct PartialSheet: ViewModifier {
    
    var sheetSize: SheetSize
    
    init(_ sheetSize: SheetSize) {
        self.sheetSize = sheetSize
    }
    
    func body(content: Content) -> some View {
        content
            .frame(height: sheetHeight())
    }
    
    private func sheetHeight() -> CGFloat {
        switch sheetSize {
        case .short:
            return UIScreen.main.bounds.height / 5.5
        case .long:
            return UIScreen.main.bounds.height / 1.8
        case .detail:
            return UIScreen.main.bounds.height / 3.5
        }
    }
}

enum SheetSize: Equatable {
    case short, long, detail
}

extension View {
    func partialSheet(_ sheetSize: SheetSize) -> some View {
        self.modifier(PartialSheet(sheetSize))
    }
}
