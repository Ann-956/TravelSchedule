import SwiftUI
import Combine

struct StoryFullView: View {
    
    @Binding private var stories: [Stories]
    private let configuration: StoryFullConfiguration
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    @Environment(\.dismiss) var dismiss
    
    private var currentStoryIndex: Int {
        Int(progress * CGFloat(stories.count))
    }
    private var currentStory: Stories {
        stories[currentStoryIndex]
    }
    
    
    init(stories: Binding<[Stories]>, initialIndex: Int = 0) {
        self._stories = stories
        self.configuration = StoryFullConfiguration(storiesCount: stories.count)
        self.timer = Self.createTimer(configuration: configuration)
        self._progress = State(initialValue: CGFloat(initialIndex) / CGFloat(stories.count))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryContentFullView(story: currentStory)
            ProgressBar(numberOfSections: stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton(action: {dismiss()})
                .padding(.top, 54)
                .padding(.trailing, 12)
        }
        .background(.ypTotalBlack)
        
        .gesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.height > 100 {
                        dismiss()
                    }
                }
        )
        .onAppear {
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            withAnimation(.linear(duration: configuration.timerTickInternal)) {
                timerTick()
            }
        }
        .onTapGesture {
            nextStory()
            resetTimer()
        }
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        progress = nextProgress
    }
    
    private func nextStory() {
        let nextIndex = currentStoryIndex + 1
        if nextIndex < stories.count {
            progress = CGFloat(nextIndex) / CGFloat(stories.count)
            stories[currentStoryIndex].isViewed = true
        } else {
            progress = 0
            dismiss()
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: StoryFullConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

#Preview {
    StoryFullView(stories: .constant(mockStories))
}
