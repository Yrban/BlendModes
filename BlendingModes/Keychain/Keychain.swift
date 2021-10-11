//
//  Keychain.swift
//  HotHorse
//
//  Created by Dev on 6/24/20.
//  Copyright © 2020 Alelin Apps. All rights reserved.
//

import SwiftUI
import Combine

final class Keychain: ObservableObject {
    
    public static let shared = Keychain()
    
    private let keychainStandard = KeychainWrapper.standard
    
    @Published var EULAAccepted: Bool
    
    @Published var privacyAccepted: Bool
    
    private init() {
        var terms = false
        if let contents = keychainStandard.string(forKey: Constant.EULAKey) {
            terms = contents == Constant.EULAAccepted
            NSLog(contents.description)
        }
        
        var privacy = false
        //        keychainStandard.set("", forKey: Constant.privacyKey)
        if let contents = keychainStandard.string(forKey: Constant.privacyKey) {
            privacy = (contents == Constant.privacyAccepted)
            NSLog(contents.description)
        }
                
        self.EULAAccepted = terms
        self.privacyAccepted = privacy
    }
    
    func toggleEULA() {
        EULAAccepted.toggle()
        keychainStandard.set(Constant.EULAAccepted, forKey: Constant.EULAKey)
    }
    
    func togglePrivacy() {
        privacyAccepted.toggle()
        keychainStandard.set(Constant.privacyAccepted, forKey: Constant.privacyKey)
    }
}

struct Constant {
    static public let EULAAccepted = "EULAAccepted 10/10/21"
    static public let privacyAccepted = "privacy 1/26/21"
    
    static let EULAKey = "EULA"
    static let privacyKey = "Privacy"

}
