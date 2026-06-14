import SwiftUI

struct EULAView: View {
    private let url = URL(string: "https://www.alelinapps.com/eula-blend-modes/")!

    var body: some View {
        UrlWebView(urlToDisplay: url)
            .navigationTitle("EULA")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EULAView()
    }
}
