import Foundation

struct Stories {
    let backgroundImage: String
    let title: String
    let description: String
    var isViewed: Bool
}

enum Mocks {
    static let stories: [Stories] = [
        .init(
            backgroundImage: "Story1",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            isViewed: false
        ),
        .init(
            backgroundImage: "Story2",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            isViewed: false
        ),
        .init(
            backgroundImage: "Story3",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            isViewed: false
        ),
        .init(
            backgroundImage: "Story4",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            isViewed: false
        ),
        .init(
            backgroundImage: "Story5",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            isViewed: false
        ),
        .init(
            backgroundImage: "Story6",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            isViewed: false
        ),
        
    ]
}


