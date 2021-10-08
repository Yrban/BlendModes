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
                .accessibility(hidden: true)
            HStack {
                Image(systemName: "minus")
                    .accessibility(hidden: true)
                Slider(value: $value, in: 0...1)
                    .accessibilityLabel(Text("\(title) slider"))
                    .accessibility(value: Text("at \(value.formatted(.percent))"))
                Image(systemName: "plus")
                    .accessibility(hidden: true)
            }
            .tint(.blue)
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
