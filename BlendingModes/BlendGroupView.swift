//
//  BlendGroupView.swift
//
//  Created by Developer on 10/1/21.
//

import SwiftUI

struct BlendGroupView: View {
    
    @ObservedObject var blendModel = BlendModel.shared
    let mode: BlendMode
    let geometry: GeometryProxy
    let offset: Int
    @State private var selection: Int? = nil
    
    init(mode: BlendMode, geometry: GeometryProxy) {
        self.mode = mode
        self.geometry = geometry
        let minDimension = Int(min(geometry.size.width, geometry.size.height))
        if BlendModel.shared.colors.count > 1 {
            self.offset = Int(minDimension / ((BlendModel.shared.colors.count) * 10))
        } else {
            self.offset = 0
        }
    }
    
    var body: some View {
        
        ZStack {
            blendModel.background
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                blendedView
                    .blendMode(mode)
                    .colorInvert(enabled: blendModel.colorInvert)
                    .compositingGroup(enabled: blendModel.compositingMode)
                    .blur(radius: blendModel.blur * 20)
                    .opacity(blendModel.opacity)
                
                overCircleView
            }
            .frame(width: (min(geometry.size.height, geometry.size.width) * 0.7), alignment: .center)
        }
    }
    
    var blendedView: some View {
        ForEach(Array(zip(blendModel.colors.indices, blendModel.colors)), id: \.1) { index, color in
            SingleView(color: color, offset: offset, count: blendModel.colors.count, index: index)
                .accessibilityLabel(Text(" the \((index + 1).ordinalFormatter()) circle of \(blendModel.colors.count), colored \(UIColor(color).accessibilityName) with the blend mode of \(mode.description) applied"))
        }
    }
    
    var overCircleView: some View {
        ForEach(blendModel.colors.indices, id: \.self) { index in
            Circle()
                .strokeBorder(Color.black, lineWidth: 2)
                .offset(x: CGFloat(offset * blendModel.colors.count), y: CGFloat(offset * blendModel.colors.count))
                .rotationEffect(.degrees(360.0 / Double(blendModel.colors.count) * Double(index)))
        }
    }
    
}

struct BlendModeView_Previews: PreviewProvider {
    static var previews: some View {
        BlendModePreview()
    }
}

struct BlendModePreview: View {
    @State var blendModel = BlendModel(colorsQty: 4)
    var body: some View {
        GeometryReader { geometry in
            BlendGroupView(mode: .normal, geometry: geometry)
        }
    }
}
