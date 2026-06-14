import SwiftUI

struct PrivacyPolicyView: View {
    private let url = URL(string: "https://www.alelinapps.com/privacy-policy/")!

    var body: some View {
        UrlWebView(urlToDisplay: url)
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
