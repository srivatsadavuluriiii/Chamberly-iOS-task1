
import SwiftUI


struct PostCardView: View {
    @State private var showAllReplies = false
    @State private var showReplyField = false
    @State private var commentText = ""
    @State private var replyText = ""
    @State private var isLiked: Bool = false
    @State private var commentsCount = 0
    @Binding var selectedCommentIndex: Int?
    @Binding var post: Post
    
//    let onAddReply: (String) -> Void
    
    func onAddReply(parentReply: Reply) {
            // Add new reply to parentReply.replies
            let newReply = Reply(id: UUID(), authorName: "You", replyContent: replyText)
            parentReply.replies.append(newReply)
            // Reset replyText and hide field
        }

    var body: some View {
        VStack(alignment: .leading) {
            
            CommentView(reply: Reply(id: UUID(), authorName: post.authorName, replyContent: post.content))
            HStack (spacing : 20){
                HStack (spacing : 3){
                    Button {
                                    isLiked.toggle()
                                    if isLiked {
                                        post.totalLikes += 1
                                    } else {
                                        post.totalLikes -= 1
                                    }
                                } label: {
                                    Image(systemName: isLiked ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                            }
                                Text("\(post.totalLikes)")
                }
                
                if showReplyField {
                            TextField("Write your reply...", text: $replyText)
                                .onSubmit {
                                    if let unwrappedIndex = selectedCommentIndex {
                                        onAddReply(parentReply: post.comments[unwrappedIndex])
                                        showReplyField = false
                                        replyText = ""
                                    } else {
                                        
                                    }
                                    showReplyField = false
                                    replyText = ""
                                }
                        }
                
                ForEach(post.comments.indices, id: \.self) { index in
                    Button(action: { selectedCommentIndex = index }) {
                        CommentView(reply: post.comments[index])
                    }
                }
                
                HStack(spacing : 3) {
                            Button {
                            action: do { showReplyField.toggle() }
                            } label: {
                                Image(systemName: "message")
                                    .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                            }

                            Text("\(post.comments.count)")
                    
                    
                    
                }
            }.padding(.horizontal,20)
            
            CommentsView(
                comments: post.comments,
                onReply: { replyText in
                    let newReply = Reply(id: UUID(), authorName: "You", replyContent: replyText)
                    onAddReply(parentReply: newReply)
                },
                showAllReplies: $showAllReplies
            )
                .padding(.bottom,20)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 0.5)
        .padding(.horizontal,40)
    }
}







struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        let examplePost = Post(
            content: "This is a sample post about SwiftUI development.", 
            authorName: "John Doe",
            comments: [
                Reply(id: UUID(), authorName: "Alice", replyContent: "Great post!"),
                Reply(id: UUID(), authorName: "Bob", replyContent: "I agree, very informative."),
                Reply(id: UUID(), authorName: "Adi", replyContent: "I agree, very informative."),
                Reply(id: UUID(), authorName: "Bob", replyContent: "I agree, very informative."),
                Reply(id: UUID(), authorName: "Bob", replyContent: "I agree, very informative."),
                Reply(id: UUID(), authorName: "Bob", replyContent: "I agree, very informative."),
                Reply(id: UUID(), authorName: "Bob", replyContent: "I agree, very informative."),
                Reply(id: UUID(), authorName: "Bob", replyContent: "I agree, very informative.")],
            totalLikes: 10
        )
        
        @State var previewPost = examplePost
        let _: (String) -> Void = { newReplyText in
            print("New reply added:", newReplyText)
        }

        return PostCardView(selectedCommentIndex: <#Binding<Int?>#>, post: $previewPost)
    }
}

