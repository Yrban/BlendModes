//
//  PrivacyPolicyView.swift
//  HotHorse
//
//  Created by Dev on 6/27/20.
//  Copyright © 2020 Alelin Apps. All rights reserved.
//

import SwiftUI

struct PrivacyPolicyView: View {
    
    @ObservedObject var keychain = Keychain.shared
    
    let url:URL = URL(string: "https://www.alelinapps.com/privacy-policy/")!
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Please acknowledge the Privacy Policy to continue.")
                    .font(.headline)
                
                UrlWebView(urlToDisplay: self.url)
                
                    HStack {
                        Button(action: {
                            self.keychain.togglePrivacy()
                        }) {
                            if self.keychain.privacyAccepted {
                                Image(systemName: "checkmark.square")
                                    .font(.largeTitle)
                            } else {
                                Image(systemName: "square")
                                    .font(.largeTitle)
                            }
                            Text(" I Have Read and Understand The Privacy Policy")
                                .font(.caption)
                        }
                    }
                    .contentShape(Rectangle())
                    .frame(height: (geometry.size.height * 0.08))
                    .padding(.top, 5)
                    .padding(.bottom)
            }
            .padding(.horizontal)
            .navigationTitle("Privacy")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
