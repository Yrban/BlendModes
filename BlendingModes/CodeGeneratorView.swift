import SwiftUI

struct CodeGeneratorView: View {
    @Environment(BlendModel.self) private var blendModel
    let mode: BlendMode
    @State private var copied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView([.horizontal, .vertical]) {
                Text(blendModel.codeSnippet(for: mode))
                    .font(.system(.caption, design: .monospaced))
                    .textSelection(.enabled)
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxHeight: 200)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Button {
                copyCode()
            } label: {
                Label(copied ? "Copied!" : "Copy Code", systemImage: copied ? "checkmark" : "doc.on.clipboard")
            }
            .animation(.easeInOut(duration: 0.2), value: copied)
        }
    }

    private func copyCode() {
        let code = blendModel.codeSnippet(for: mode)
        #if canImport(UIKit)
        UIPasteboard.general.string = code
        #elseif canImport(AppKit)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(code, forType: .string)
        #endif
        copied = true
        Task {
            try? await Task.sleep(for: .seconds(2))
            copied = false
        }
    }
}

#Preview {
    List {
        CodeGeneratorView(mode: .multiply)
    }
    .environment(BlendModel(colors: [.red, .blue]))
}
