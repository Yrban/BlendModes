//
//  InformationView.swift
//  BlendingModes
//
//  Created by Developer on 10/7/21.
//

import SwiftUI

struct InformationView: View {
    @ObservedObject var blendModel = BlendModel.shared
    var mode: BlendMode = .color
    
    var body: some View {
        ScrollViewReader { value in
            List {
                ForEach(BlendMode.allCases, id: \.anchor) { blendMode in
                    VStack {
                        Text(blendMode.description)
                            .accessibility(hidden: true)
                        Text(blendMode.longDescription)
                            .id(blendMode.anchor)
                    }
                    .onAppear {
                        value.scrollTo(mode.anchor, anchor: .top)
                    }
                }
                VStack {
                    Text(".colorInvert()")
                        .accessibility(hidden: true)
                    Text(colorInvert)
                }
                VStack {
                    Text(".compositingGroup()()")
                        .accessibility(hidden: true)
                    Text(colorInvert)
                }

            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .glow(with: blendModel.background)
            .navigationTitle(Text("Blend Mode Info"))
        }
    }
    
    let colorInvert = """
The colorInvert() modifier inverts all of the colors in a view so that each color displays as its complementary color. For example, blue converts to yellow, and white converts to black.
"""
    let compositing = """
A compositing group makes compositing effects in this view’s ancestor views, such as opacity and the blend mode, take effect before this view is rendered.
Use compositingGroup() to apply effects to a parent view before applying effects to this view. In Blend Modes, the circles are all in the compositing group, and the background is not. This allows you to isolate the circles from the background, or not. This allows you to further explore the different blend modes.

"""
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
