//
//  PrivacyEULATabBar.swift
//  HotHorse
//
//  Created by Developer on 10/18/20.
//

import SwiftUI

struct PrivacyEULATabBar: View {
    
    @ObservedObject var keychain = Keychain.shared

    @State private var selection = 0

    var body: some View {
        TabView {
            EULAView()
                .tabItem {
                    Text("EULA")}
                .tag(0)

            PrivacyPolicyView()
                .tabItem {
                    Text("Privacy Policy")}
                .tag(1)
        }
        .animation( .easeInOut, value: selection)
        .transition(.slide)
    }
}

struct PrivacyEULATabBar_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyEULATabBar()
    }
}
