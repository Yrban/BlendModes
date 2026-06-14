import SwiftUI

struct BlendModeDetail: View {
    @Environment(BlendModel.self) private var blendModel
    let mode: BlendMode
    @State private var showInfo = false

    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section("Colors") {
                    ChooseColorsView()
                }
            }
            .frame(maxHeight: 240)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
            .padding(.top)

            BlendGroupView(mode: mode)
                .aspectRatio(1, contentMode: .fit)
                .padding()
                .layoutPriority(1)

            Form {
                Section("Adjustments") {
                    AdjustModeView()
                }
            }
            .frame(maxHeight: 220)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
            .padding(.bottom)
        }
        .glow(with: blendModel.background)
        .navigationTitle(mode.description)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showInfo = true
                } label: {
                    Image(systemName: "info.circle")
                        .accessibilityLabel("Blend mode information")
                }
            }
        }
        .sheet(isPresented: $showInfo) {
            NavigationStack {
                InformationView(mode: mode)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { showInfo = false }
                        }
                    }
            }
            .environment(blendModel)
        }
    }
}

#Preview {
    NavigationStack {
        BlendModeDetail(mode: .multiply)
            .environment(BlendModel(colors: [.red, .blue, .green]))
    }
}
