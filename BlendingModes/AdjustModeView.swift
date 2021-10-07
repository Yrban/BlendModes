//
//  AdjustModeView.swift
//  BlendingModes
//
//  Created by Developer on 10/2/21.
//

import SwiftUI

struct AdjustModeView: View {
    
    @ObservedObject var blendModel = BlendModel.shared
    
    
    var body: some View {
        Toggle(("Color Invert"), isOn: $blendModel.colorInvert)
        Toggle("Compositing Mode", isOn: $blendModel.compositingMode)
        SliderView(value: $blendModel.opacity, title: "Opacity")
        SliderView(value: $blendModel.blur, title: "Blur")
    }
    
}

struct ToggleModeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AdjustModeView()
        }
        .listStyle(.plain)
    }
}
