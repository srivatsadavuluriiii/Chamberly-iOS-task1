

import SwiftUI

class MessageFieldViewModel: ObservableObject {
	@Published var text: String = ""
	@Published var names = ["Kristian", "John", "Alice"]
	@Published var totalLikes = 0
	@Published var replyContent: [Reply] = [
		Reply(authorName: "John", replyContent: "Great post!"),
		Reply(authorName: "Alice", replyContent: "I agree."),
		Reply(authorName: "Kristian", replyContent: "Interesting topic.")
	]
	@FocusState var isFocused: Bool
    @Published var posts: [String: Post] = [:]
    
    @Published var shouldFocusTextField = false

	func focusTextField() {
        shouldFocusTextField = true
    }
}

