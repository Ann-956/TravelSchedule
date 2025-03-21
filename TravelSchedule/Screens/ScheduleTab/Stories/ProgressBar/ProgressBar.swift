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



