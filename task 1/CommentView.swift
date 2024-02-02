//
//  CommentView.swift
//  task 1
//
//  Created by srivatsa davuluri on 02/02/24.
//

//import SwiftUI
//
//struct CommentView: View {
//    var reply: Reply
//    let isPost: Bool = false
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Text(reply.authorName)
//                    .font(.headline)
//                Spacer()
//                // Like and reply buttons for the comment
//            }
//            Text(reply.replyContent)
//                .font(.footnote)
////
//            if !reply.replies.isEmpty {
//                // Move the func outside of the ViewBuilder to avoid the error
//
//                // Pass reply as inout to allow modification within the closure
//                modifyReplies(reply: &reply, onReply: { text in
//                    reply.replies.append(Reply(id: UUID(), authorName: "You", replyContent: text))
//                })
//            }
//        }
//        .padding(15)
//    }
//    
//    func modifyReplies(reply: inout Reply, onReply: @escaping (String) -> Void) {
//            CommentsView(comments: reply.replies, onReply: onReply, showAllReplies: .constant(true))
//        }
//}

//
//import SwiftUI
//
//
//
//struct CommentView: View {
//    var reply: Reply
//    let isPost: Bool = false
//    @State var mutableReply: Reply
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            // ... other views
//
//            if !reply.replies.isEmpty {
//                ModifyRepliesView(reply: reply, onReply: onReplyAppended) // Use correct argument names
//                }
//        }
//        .padding(15)
//    }
//
//    mutating func onReplyAppended(text: String) {
//        reply.replies.append(Reply(id: UUID(), authorName: "You", replyContent: text))
//    }
//}
//
//struct ModifyRepliesView: View {
//    @State var mutableReply: Reply
//    var reply: Reply
//    var onReply: (String) -> Void
//
//    var body: some View {
//        CommentsView(comments: mutableReply.replies, onReply: onReply, showAllReplies: .constant(true))
//            .onAppear {
//                // Create a mutable copy of the reply when the view appears
//                self.mutableReply = reply
//            }
//    }
//}
//
import SwiftUI



struct CommentView: View {
    @State private var isSelected: Bool = false
    let isPost: Bool = false
    let reply: Reply
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(reply.authorName)
                    .font(.headline)
                Spacer()
            }
            Text(reply.replyContent)
                .font(.footnote)
            
            if !reply.replies.isEmpty {
                ForEach(reply.replies) { childReply in
                    CommentView(reply: childReply) // Recursive call
                        .padding(.horizontal)
                }
            }
        }
        .padding(15)
    }
    
    func onReplyAppended(text: String) {
        reply.replies.append(Reply(id: UUID(), authorName: "You", replyContent: text))
    }
}





struct ModifyRepliesView: View {
    @State var mutableReply: Reply
    var onReply: (String) -> Void
    
    var body: some View {
        CommentsView(comments: mutableReply.replies, onReply: onReply, showAllReplies: .constant(true))
            .onAppear {
                self.mutableReply = self.mutableReply // Adjust to use the existing property
            }
    }
    
    
    // Initialize with the reply to be modified
    init(reply: Reply, onReply: @escaping (String) -> Void) {
        self._mutableReply = State(initialValue: reply) // Initialize the mutableReply property
        self.onReply = onReply
    }
}





struct CommentsView: View {
    let comments: [Reply]
    let onReply: (String) -> Void
    @Binding var showAllReplies: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(showAllReplies ? comments : Array(comments.prefix(2))) { reply in
                CommentView(reply: reply)
                    .padding(.horizontal)
            }
            if !showAllReplies && comments.count > 2 {
                Button(action: { showAllReplies.toggle() }) {
                    Text("Show all replies")
                        .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                }
            }
        }
    }
}






struct  CommentView_Previews : PreviewProvider {
    static var previews: some View {
        CommentView(reply: Reply(id: UUID(), authorName: "Aditya Chheda", replyContent: "I am gay", likeCount: 20, isLiked: true, replies: [Reply(authorName: "Srivatsa", replyContent: "Me too"),]))
    }
}
