//
//  HelpView.swift
//  BlendingModes
//
//  Created by Developer on 10/10/21.
//

import SwiftUI

struct HelpView: View {
    
    let url:URL = URL(string: "https://github.com/Yrban/BlendingModes")!
    
    var body: some View {
        ScrollView {
            Text(helpText)
            Button(action: {
                    UIApplication.shared.open(self.url) })
            {
                    Text("github.com/Yrban/BlendingModes")
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Help")
        
    }
    
    let helpText = """
Blend Modes is a simple application to assist iOS developers using SwiftUI and UIKit to explore blends with or without compositing, color inverts, blurs and opacity changes. For those of us not trained in digital art, understanding a .blendMode() and what it will look like on screen is not intuitive. You will find the color interacting in unexpected ways. A complete explanation is provided for each blend mode.

When you start on an iPhone you will see the "Mode" view. This view is made up of the "Settings" view at the top, and the "Selection" view below. The selection view allows you to choose between the different blend modes, and shows you a small preview of what it looks like with the current selections.

You should see "Color Invert" and "Compositing Mode" initially in the "Mode" view. The colorInvert() modifier inverts all of the colors in a view so that each color displays as its complementary color. For example, blue converts to yellow, and white converts to black.

A compositing group makes compositing effects in this view’s ancestor views, such as opacity and the blend mode, take effect before this view is rendered.

Use compositingGroup() to apply effects to a parent view before applying effects to this view. In Blend Modes, the circles are all in the compositing group, and the background is not. This allows you to isolate the circles from the background, or not. This allows you to further explore the different blend modes.

Clicking on the accordion fold button will slide the "Selection" view down revealing more of the view underneath. This will reveal the "Opacity" and "Blur" sliders. Below these are the "ColorPickers" and "Add New Color" button. You can have up to five different colors plus the background color.

Clicking on a particular blend mode will bring up that blend mode's detail view. This view will also allow you to perform all of the adjustments of the Settings view, and will show you the effect with this particular blend mode. Please note, this is an app wide adjustment and it will affect the other blend modes.

The complete project is at:
"""
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HelpView()
        }
    }
}
