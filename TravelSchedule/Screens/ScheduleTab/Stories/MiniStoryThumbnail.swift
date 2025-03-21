import SwiftUI

struct MiniStoryThumbnail: View {
    @Binding var story: Stories
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.backgroundImage)
                .resizable()
                .scaledToFill()
                .frame(width: 92, height: 140)
            
            Text(story.title)
                .font(.system(size: 12))
                .lineLimit(3)
                .foregroundStyle(.white)
                .padding(.bottom, 12)
                .padding(.horizontal, 8)
        }
        .frame(width: 92, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            Group {
                if story.isViewed {
                    themeManager.isDarkMode
                    ? Color.ypTotalBlack.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 16))
                    : Color.ypTotalWhite.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.ypBlue, lineWidth: 4)
                }
            }
        )
    }
}

#Preview {
    MiniStoryThumbnail(story: .constant(Mocks.stories[0]))
        .environmentObject(ThemeManager())
}
