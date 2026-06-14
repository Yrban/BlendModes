import SwiftUI

struct SingleView: View {
    let color: Color
    let offset: Int
    let count: Int
    let index: Int

    var body: some View {
        Circle()
            .fill(color)
            .offset(x: CGFloat(offset * count), y: CGFloat(offset * count))
            .rotationEffect(.degrees(360.0 / Double(max(count, 1)) * Double(index)))
    }
}

#Preview {
    SingleView(color: .red, offset: 0, count: 1, index: 0)
}
