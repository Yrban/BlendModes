//
//  ContentView.swift
//  BlendingModes
//
//  Created by Developer on 10/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var keychain = Keychain.shared
    @ObservedObject var blendModel = BlendModel.shared
    @State private var sheetSize = SheetSize.short
    @State private var privAndEULA: Bool
    
    init() {
        _privAndEULA = State(initialValue: Keychain.shared.EULAAccepted && Keychain.shared.privacyAccepted)
    }
    
    var body: some View {
        NavigationView {
            if privAndEULA {
                VStack {
                    SettingsView()
                        .partialSheet(sheetSize)
                    
                    Form {
                        ForEach(BlendMode.allCases, id: \.self) { mode in
                            NavigationLink {
                                BlendModeDetail(mode: mode)
                            } label: {
                                blendModeLabel(mode: mode)
                                    .accessibilityElement(children: .ignore)
                                    .accessibility(label: Text("Select blend mode \(mode.description)"))
                            }
                        }
                    }
                    // Faking a shadow as putting a shadow on the view causes it to expand wider than the main list window on iPad
                    .background(
                        ZStack {
                            Color.gray
                                .opacity(0.1)
                                .offset(x: 0, y: -10)
                            Color.gray
                                .opacity(0.2)
                                .offset(x: 0, y: -7)
                            Color.gray
                                .opacity(0.3)
                                .offset(x: 0, y: -3)
                        }
                    )
                    .ignoresSafeArea()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.3)) {
                                switchSheet()
                            }
                        } label: {
                            Image(systemName: "map")
                                .rotationEffect(.degrees(90))
                                .accessibility(label: Text("View all controls."))
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: HelpView()) {
                            Image(systemName: "questionmark.circle")
                                .accessibility(label: Text("Help"))
                        }
                    }
                }
                .navigationTitle("Modes")
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(blendModel.$compositingMode) { _ in
                    withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.3)) {
                        sheetSize = .short
                    }
                }
                BlendModeDetail(mode: .normal)
            } else {
                PrivacyEULATabBar()
            }
            
        }
        .glow(with: blendModel.background)
        .onReceive(keychain.objectWillChange) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1)) {
                    privAndEULA = keychain.EULAAccepted && keychain.privacyAccepted
                }
            }
        }
    }
    
    func blendModeLabel(mode: BlendMode) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                blendLabel(mode: mode)
                backgroundLabel
            }
            //            .layoutPriority(1)
            
            Spacer()
            
            GeometryReader { geometry in
                BlendGroupView(mode: mode, geometry: geometry)
            }
            .frame(idealWidth: 75, idealHeight: 75)
            .fixedSize()
            .padding(.leading)
        }
        
    }
    
    func blendLabel(mode: BlendMode) -> some View {
        VStack {
            HStack {
                Text("Blend Mode:")
                Spacer()
            }
            HStack {
                Spacer()
                Text(mode.description)
            }
        }
    }
    
    var backgroundLabel: some View {
        VStack {
            HStack {
                Text("Background:")
                Spacer()
            }
            HStack {
                Spacer()
                Text(UIColor(blendModel.background).accessibilityName)
            }
        }
    }
    
    private func switchSheet() {
        switch sheetSize {
        case .short:
            sheetSize = .long
        case .long:
            sheetSize = .short
        default:
            break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
