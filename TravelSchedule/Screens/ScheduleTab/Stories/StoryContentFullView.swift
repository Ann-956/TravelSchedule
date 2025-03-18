import SwiftUI

struct StoryContentFullView: View {
    var story: Stories
    
    var body: some View {
        ZStack {
            Image(story.backgroundImage)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 40))
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(story.title)
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(2)
                        .padding(.bottom, 16)
                    
                    Text(story.description)
                        .font(.system(size: 20))
                        .lineLimit(3)
                        .padding(.bottom, 40)
                }
                .foregroundStyle(.ypTotalWhite)
                .padding(.horizontal, 16)

            }
        }
        
    }
}
#Preview {
    Color.black
        .ignoresSafeArea()
        .overlay {
            StoryContentFullView(story: mockStories[0])
        }
}
