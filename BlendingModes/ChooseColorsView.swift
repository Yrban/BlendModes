//
//  ChooseColorsView.swift
//  BlendingModes
//
//  Created by Developer on 10/2/21.
//

import SwiftUI

struct ChooseColorsView: View {
    
    @ObservedObject var blendModel = BlendModel.shared
    var body: some View {
        
        ForEach(blendModel.colors.indices, id: \.self) { index in
            ColorPicker("Choose a color:", selection: $blendModel.colors[index], supportsOpacity: false)
                .accessibilityElement(children: .ignore)
                .accessibility(label: Text("Change the \((index + 1).ordinalFormatter()) color from \(UIColor(blendModel.colors[index]).accessibilityName)"))
                .deleteDisabled(blendModel.colors.count == 1)
        }
        .onDelete(perform: { indexSet in blendModel.colors.remove(atOffsets:indexSet) })
        
        Button {
            withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.3)) {
                blendModel.addColor(color: .random)
            }
        } label: {
            Label {
                Text("Add New Color")
            } icon: {
                Image(systemName: "plus.circle")
            }
        }
        .disabled(blendModel.colors.count > 4)
        .accessibility(label: Text("Add New Color"))
        
        ColorPicker("Choose a background color:", selection: $blendModel.background, supportsOpacity: false)
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("Change the background color from \(UIColor(blendModel.background).accessibilityName)"))
    }
}


struct ChooseColorsView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseColorsView()
    }
}
