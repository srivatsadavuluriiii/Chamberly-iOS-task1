import SwiftUI

struct ContentView: View {
    @EnvironmentObject var messageFieldVM: MessageFieldViewModel
    @FocusState var isTextFieldFocused: Bool
    @State private var posts: [Post] = []
    @State private var newCommentText: String = ""
    @State private var namesBinding = messageFieldVM.names

    var body: some View {
        ZStack {
            
            
          Color(#colorLiteral(red: 0.968626678, green: 0.9686279893, blue: 0.9987213016, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                
                
                Text("Swipe right to start chatting!")
                    .font(.footnote)
                    .fontWeight(.medium)
                
                
                
                RoundedRectangle(cornerRadius: 30)
                            .fill(LinearGradient(colors: [Color(#colorLiteral(red: 0.6588120461, green: 0.6588326097, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1))], startPoint: .top, endPoint: .bottom))
                            .frame(width: 330, height: 130)
                            .overlay(
                                Text("How to overcome daily anxiety?")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            )
                
                
                
                HStack (spacing: 20){
                    HStack(spacing: 5){
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            
                        Text("\(posts.reduce(0) { $0 + $1.totalLikes })")
                            .foregroundColor(.red)
                    }
                        
                    HStack (spacing: 5){
                        Image(systemName: "message")
                            .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                        Text("\(posts.reduce(0) { $0 + $1.comments.count })")
                            .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                    }
                    
                }
                // Scroll view for posts
//                ScrollView {
//                    VStack(spacing: 15) {
//                        ForEach($posts) { $post in // Use $posts to create a Binding to each post
//                                    PostCardView(post: $post, onAddReply: { text in
//                                var mutablePost = post
//                                mutablePost.addReply(text: text)
//                                
//                            })
//                        }
//                    }
//                }
                
                
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(namesBinding, id: \.self) { name in
                                    let postBinding = Binding(
                                        get: { messageFieldVM.posts[name] },
                                        set: { messageFieldVM.posts[name] = $0 }
                                    )

                                    PostCardView(post: postBinding, onAddReply: { text in
                                        
                                        let reply = Reply(authorName: "Aditya Chheda", replyContent: text)
                                        messageFieldVM.replyContent.append(reply)
                                        messageFieldVM.posts[name]?.comments.append(reply)
                                    })
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                }
                            }
                        

                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: 350, height: 80)
                    .overlay(
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(Color(#colorLiteral(red: 0.4784063697, green: 0.4784510732, blue: 1, alpha: 1)))
                                .padding(.horizontal, 20)

                            TextField("Reply to \(messageFieldVM.names.first ?? "")", text: $messageFieldVM.text)
                                .opacity(0.6)
                                .padding(.horizontal)
                                .focused($isTextFieldFocused)

                            Button {
                                
                                let reply = Reply(authorName: "Aditya Chheda", replyContent: messageFieldVM.text)
                                messageFieldVM.replyContent.append(reply)
                                messageFieldVM.text = ""
                            } label: {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.4784063697, green: 0.4784510732, blue: 1, alpha: 1)))
                                    .padding(.horizontal, 30)
                        }
                    }
                )
            }
        } .onTapGesture { isTextFieldFocused = false}
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(MessageFieldViewModel())
    }
}









//
//
//struct MessageFieldView: View {
//    @EnvironmentObject var messageFieldVM: MessageFieldViewModel
//    @FocusState var isTextFieldFocused: Bool
//    @State private var posts: [Post] = []
//    @State private var newCommentText: String = ""
//
//    var body: some View {
//        ZStack {
//            Color(UIColor(red: 0.997428, green: 0.9672407508, blue: 0.9982981086, alpha: 1))
//                .edgesIgnoringSafeArea(.all)
//
//            VStack {
//                
//                Text("Swipe right to start chatting!")
//                    .font(.footnote)
//                    .fontWeight(.medium)
//                
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(LinearGradient(colors: [Color(#colorLiteral(red: 0.5254709125, green: 0.5255054832, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.6548902988, green: 0.6549112201, blue: 1, alpha: 1))],startPoint: .bottom, endPoint: .top))
//                    .padding(.horizontal, 20)
//                    .frame(width: 350, height: 150)
//                    .padding(.bottom, 20)
//                    .overlay {
//                        Text("How to overcome daily anxiety ?")
//                            .fontWeight(.semibold)
//                            .padding(.bottom)
//                            .frame(width: 240)
//                            .multilineTextAlignment(.center)
//                            .font(.title3)
//                            .foregroundColor(.white)
//                        
//                    }
//
//                Spacer()
//
////                HStack(alignment: .center, spacing: 40) {
////                    HStack(alignment: .center) {
////                        Image(systemName: "heart.fill")
////                            .foregroundColor(.pink)
////                        Text("\(messageFieldVM.totalLikes)")
////                            .foregroundColor(.red)
////                    }
////
////                    HStack (alignment: .center,spacing: 1){
////                        Image(systemName: "message")
////                            .foregroundColor(Color(#colorLiteral(red: 0.286260426, green: 0.2862856686, blue: 0.6124936938, alpha: 1)))
////                        Text("\(messageFieldVM.names.count)")
////                            .foregroundColor(Color(#colorLiteral(red: 0.286260426, green: 0.2862856686, blue: 0.6124936938, alpha: 1)))
////                            .padding(.leading, 5)
////                    }
////                    
////                }
//                
//                HStack (spacing: 20){
//                    HStack(spacing: 5){
//                        Image(systemName: "heart.fill")
//                            .foregroundColor(.red)
//                            
//                        Text("\(posts.reduce(0) { $0 + $1.totalLikes })")
//                            .foregroundColor(.red)
//                    }
//                        // Add a spacer to center the content
//                    HStack (spacing: 5){
//                        Image(systemName: "message")
//                            .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
//                        Text("\(posts.reduce(0) { $0 + $1.comments.count })")
//                            .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
//                    }
//                    
//                }
//                
//                
//                
//
//                ScrollView(.vertical, showsIndicators: false) {
//                            ForEach(messageFieldVM.names, id: \.self) { name in
//                                if let post = messageFieldVM.posts[name] { // Retrieve the Post value
//                                    let postBinding = Binding<Post>(
//                                        get: { post },
//                                        set: { messageFieldVM.posts[name] = $0 } // Update the Post value in the dictionary
//                                    )
//
//                                    let onAddReply: (String) -> Void = { text in
//                                        // Implement logic to handle adding a reply
//                                    }
//
//                                    PostCardView(post: postBinding, onAddReply: onAddReply)
//                                        .padding(.horizontal)
//                                        .padding(.vertical, 5)
//                                }
//                            }
//                        }
//                
//                
//                
//                ScrollView(.vertical, showsIndicators: false) {
//                            ForEach(messageFieldVM.names, id: \.self) { name in
//                                if let post = messageFieldVM.posts[name] {
//                                    let postBinding = Binding<Post>(
//                                        get: { post },
//                                        set: { messageFieldVM.posts[name] = $0 }
//                                    )
//
//                                    PostCardView(post: postBinding, onAddReply: { text in
//                                        // Handle adding a reply directly here
//                                        let reply = Reply(authorName: "Aditya Chheda", replyContent: text)
//                                        messageFieldVM.replyContent.append(reply)
//                                        messageFieldVM.posts[name]?.comments.append(reply) // Update replies in Post model
//                                    })
//                                    .padding(.horizontal)
//                                    .padding(.vertical, 5)
//                                }
//                            }
//                        }
//                
//            Spacer()
//                
//                
//
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(.white)
//                    .frame(width: 350, height: 80)
//                    .overlay(
//                        HStack {
//                            Image(systemName: "person.crop.circle")
//                                .foregroundColor(Color(#colorLiteral(red: 0.4784063697, green: 0.4784510732, blue: 1, alpha: 1)))
//                                .padding(.horizontal, 20)
//
//                            TextField("Reply to \(messageFieldVM.names.first ?? "")", text: $messageFieldVM.text)
//                                .opacity(0.6)
//                                .padding(.horizontal)
//                                .focused($isTextFieldFocused)
//
//                            Button {
//                                // Handle sending a reply
//                                let reply = Reply(authorName: "Aditya Chheda", replyContent: messageFieldVM.text)
//                                messageFieldVM.replyContent.append(reply)
//                                messageFieldVM.text = ""
//                            } label: {
//                                Image(systemName: "paperplane.fill")
//                                    .foregroundColor(Color(#colorLiteral(red: 0.4784063697, green: 0.4784510732, blue: 1, alpha: 1)))
//                                    .padding(.horizontal, 30)
//                            }
//                        }
//                    )
//                    .padding(.bottom, 15)
//                    .padding(.top, 15)
//            }
//        }
//        .onTapGesture {
//            isTextFieldFocused = false
//        }
//    }
//}
