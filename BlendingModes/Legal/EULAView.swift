//
//  EULAView.swift
//  HotHorse
//
//  Created by Dev on 6/27/20.
//  Copyright © 2020 Alelin Apps. All rights reserved.
//

import SwiftUI

struct EULAView: View {
    
    //    @Environment(\.presentationMode) var presentationMode
    //
    @ObservedObject var keychain = Keychain.shared
    
    let url:URL = URL(string: "https://www.alelinapps.com/eula-blend-modes/")!
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Please accept the EULA, and acknowledge the Privacy Policy to continue.")
                        .font(.headline)
                    
                    UrlWebView(urlToDisplay: self.url)
                    
                    if !(self.keychain.EULAAccepted && self.keychain.privacyAccepted) {
                        HStack {
                            Button(action: {
                                self.keychain.toggleEULA()
                            }) {
                                if self.keychain.EULAAccepted {
                                    Image(systemName: "checkmark.square")
                                        .font(.largeTitle)
                                } else {
                                    Image(systemName: "square")
                                        .font(.largeTitle)
                                }
                                Text(" I Have Read and Understand The\nEnd User License Agreement")
                                    .font(.caption)
                            }
                        }
                        .contentShape(Rectangle())
                        .frame(height: (geometry.size.height * 0.08))
                        .padding(.top, 5)
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
                .navigationTitle("EULA")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct EULAView_Previews: PreviewProvider {
    static var previews: some View {
        EULAView()
    }
}
