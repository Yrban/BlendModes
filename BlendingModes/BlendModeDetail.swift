//
//  BlendModeDetail.swift
//  BlendingModes
//
//  Created by Developer on 10/2/21.
//

import SwiftUI

struct BlendModeDetail: View {

    @ObservedObject var blendModel = BlendModel.shared
    let mode: BlendMode
    
    var body: some View {
        VStack {
            VStack {
                ChooseColorsView()
            }
            .padding()
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            GeometryReader { geometry in
                BlendGroupView(mode: mode, geometry: geometry)
            }
            VStack {
                AdjustModeView()
            }
            .padding()
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .glow(with: blendModel.background)
        .padding(.bottom)
        .navigationTitle(Text(mode.description))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: InformationView(mode: mode)) {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

struct BlendModeDetail_Previews: PreviewProvider {
    static var previews: some View {
        BlendModeDetail(mode: .normal)
    }
}
