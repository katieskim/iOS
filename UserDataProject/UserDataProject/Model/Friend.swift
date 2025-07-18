//
//  Friend.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/17/25.
//

import SwiftUI
import Foundation
import SwiftData

@Model
class FriendEntity {
    @Attribute(.unique) var id: String
    var name: String

    init(from friend: Friend) {
        self.id = friend.id
        self.name = friend.name
    }

    func toFriend() -> Friend {
        return Friend(id: id, name: name)
    }
}

struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}
