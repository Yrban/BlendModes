//
//  SingleView.swift
//  BlendingModes
//
//  Created by Developer on 10/5/21.
//

import SwiftUI

struct SingleView: View {
    let color: Color
    let offset: Int
    let count: Int
    let index: Int
    
    init(color: Color, offset: Int, count: Int, index: Int) {
        self.color = color
        self.offset = offset
        self.count = count
        self.index = index
    }
    
      var body: some View {
        Circle()
            .fill(color)
            .offset(x: CGFloat(offset * count), y: CGFloat(offset * count))
            .rotationEffect(.degrees(360.0 / Double(max(count, 1)) * Double(index)))
    }
}

struct SingleView_Previews: PreviewProvider {
    static var previews: some View {
        SingleView(color: .red, offset: 0, count: 0, index: 0)
    }
}

