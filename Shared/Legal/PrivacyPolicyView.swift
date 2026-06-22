import SwiftUI

struct PrivacyPolicyView: View {
    private let url = URL(string: "https://www.alelinapps.com/privacy-policy/")!
    @Environment(\.openURL) private var openURL

    var body: some View {
        #if os(macOS)
        VStack(spacing: 16) {
            Text("This document opens in your browser.")
                .foregroundStyle(.secondary)
            Button("Open Privacy Policy in Browser") {
                openURL(url)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Privacy Policy")
        #else
        UrlWebView(urlToDisplay: url)
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
