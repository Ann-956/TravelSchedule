import SwiftUI

struct StoriesCollectionView: View {
    @State private var stories: [Stories] = Mocks.stories
    @State private var showFullScreen: Bool = false
    @State private var selectedIndex: Int = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(stories.enumerated()), id: \.offset) { index, story in
                    Button {
                        selectedIndex = index
                        stories[index].isViewed = true
                        showFullScreen = true
                    } label: {
                        MiniStoryThumbnail(story: $stories[index])
                    }
                }
            }
            .padding(.vertical, 24)
            .padding(.leading, 16)
        }
        .fullScreenCover(isPresented: $showFullScreen) {
            StoryFullView(stories: $stories, initialIndex: selectedIndex)
        }
    }
}


#Preview {
    StoriesCollectionView()
}
