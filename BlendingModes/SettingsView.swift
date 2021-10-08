//
//  SettingsView.swift
//  BlendingModes
//
//  Created by Developer on 10/1/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var blendModel = BlendModel.shared
    @State var count: Int = BlendModel.shared.colors.count
    @State var colorSelection: Color = .clear
    
    var body: some View {
        Form {
            Section(header: Text("Please choose your modes:")) {
                AdjustModeView()
            }
            .accessibilityRemoveTraits(.isHeader)

            Section(header: Text("Please set your colors:")) {
                ChooseColorsView()
            }
            .accessibilityRemoveTraits(.isHeader)
        }
        
        .onReceive(blendModel.objectWillChange) { _ in
            withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.3)) {
                count = blendModel.colors.count
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            NavigationView {
                SettingsView()
                    .preferredColorScheme(scheme)
            }
        }
    }
}

extension UUID: Identifiable {
    public var id: UUID {
        return self
    }
    
    
}
