import SwiftUI

struct EULAView: View {
    private let url = URL(string: "https://www.alelinapps.com/eula-blend-modes/")!
    @Environment(\.openURL) private var openURL

    var body: some View {
        #if os(macOS)
        VStack(spacing: 16) {
            Text("This document opens in your browser.")
                .foregroundStyle(.secondary)
            Button("Open EULA in Browser") {
                openURL(url)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("EULA")
        #else
        UrlWebView(urlToDisplay: url)
            .navigationTitle("EULA")
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        EULAView()
    }
}
