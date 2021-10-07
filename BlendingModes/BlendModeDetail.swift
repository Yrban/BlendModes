//
//  BlendModeDetail.swift
//  BlendingModes
//
//  Created by Developer on 10/2/21.
//

import SwiftUI

struct BlendModeDetail: View {
    let mode: BlendMode
    
    var body: some View {
        VStack {
            List {
                ChooseColorsView()
            }
            .listStyle(.plain)
            .partialSheet(.detail)
            
            GeometryReader { geometry in
                BlendGroupView(mode: mode, geometry: geometry)
            }
            
            AdjustModeView()
                .padding(.horizontal)
        }
        .padding(.bottom)
        .navigationTitle(Text(mode.description))
        .toolbar {
            NavigationLink(destination: InformationView(mode: mode)) {
                Image(systemName: "info.circle")
            }
        }
    }
}

struct BlendModeDetail_Previews: PreviewProvider {
    static var previews: some View {
        BlendModeDetail(mode: .normal)
    }
}
