//
//  SliderView.swift
//  BlendingModes
//
//  Created by Developer on 10/7/21.
//

import SwiftUI

struct SliderView: View {
    
    @Binding var value: Double
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
        HStack {
            Image(systemName: "minus")
            Slider(value: $value, in: 0...1)
            Image(systemName: "plus")
        }
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderPreview()
    }
}

struct SliderPreview: View {
    @State var value = 0.5
    let title = "title"
    var body: some View {
        SliderView(value: $value, title: title)
    }
}
