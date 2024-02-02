//
//  Post.swift
//  task 1
//
//  Created by srivatsa davuluri on 02/02/24.
//

import Foundation

class Post: Identifiable {
    let id = UUID()
    let content: String
    var authorName: String
    var comments: [Reply]
    var totalLikes: Int

    init(content: String, authorName: String, comments: [Reply] = [], totalLikes: Int = 0) { 
        self.content = content
        self.authorName = authorName
        self.comments = comments
        self.totalLikes = totalLikes
    }

    func addReply(text: String) {
        comments.append(Reply(id: UUID(), authorName: "You", replyContent: text))
    }
}





class Reply: Identifiable {
    let id: UUID
    let authorName: String
    let replyContent: String
    var likeCount: Int
    var isLiked: Bool
    var replies: [Reply]

    init(id: UUID = UUID(), authorName: String, replyContent: String, likeCount: Int = 0, isLiked: Bool = false, replies: [Reply] = []) {
        self.id = id
        self.authorName = authorName
        self.replyContent = replyContent
        self.likeCount = likeCount
        self.isLiked = isLiked
        self.replies = replies
    }
}

