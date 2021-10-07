//
//  ContentView.swift
//  BlendingModes
//
//  Created by Developer on 10/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var blendModel = BlendModel.shared
    @State var sheetSize = SheetSize.short
    
    var body: some View {
        NavigationView {
            VStack {
                SettingsView()
                    .partialSheet(sheetSize)
                
                List {
                    ForEach(BlendMode.allCases, id: \.self) { mode in
                        NavigationLink {
                            BlendModeDetail(mode: mode)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
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
                                .layoutPriority(1)
                                
                                Spacer()
                                
                                GeometryReader { geometry in
                                    BlendGroupView(mode: mode, geometry: geometry)
                                }
                                .frame(idealWidth: 100, idealHeight: 100)
                                .fixedSize()
                                .padding(.leading)
                            }
                        }
                    }
                }
                .shadow(color: .gray, radius: 20, x: 0, y: 0)
                
            }
            .toolbar {
                Button {
                    withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.3)) {
                        switchSheet()
                    }
                } label: {
                    Image(systemName: "map")
                        .rotationEffect(.degrees(90))
                }
            }
            .navigationTitle("Blend Modes")
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(blendModel.$compositingMode) { _ in
                withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.3)) {
                    sheetSize = .short
                }
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
