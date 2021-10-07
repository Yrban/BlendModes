//
//  InformationView.swift
//  BlendingModes
//
//  Created by Developer on 10/7/21.
//

import SwiftUI

struct InformationView: View {
    
    var mode: BlendMode = .color
    
    var body: some View {
        ScrollViewReader { value in
            List {
                ForEach(BlendMode.allCases, id: \.anchor) { blendMode in
                    VStack {
                        Text(blendMode.description)
                        Text(blendMode.longDescription)
                            .id(blendMode.anchor)
                    }
                    .onAppear {
                        value.scrollTo(mode.anchor, anchor: .top)
                    }
                }
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
