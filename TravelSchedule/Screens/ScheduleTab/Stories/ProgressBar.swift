import SwiftUI

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: geometry.size.width, height: 6)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 3)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: 6
                    )
                    .foregroundColor(.ypBlue)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

private struct MaskView: View {
    let numberOfSections: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: 6)
            .foregroundStyle(.ypTotalWhite)
    }
}



#Preview {
    Color.black
        .ignoresSafeArea()
        .overlay(
            HStack {
                MaskFragmentView()
                MaskFragmentView()
                MaskFragmentView()
            }.padding()
        )
}



