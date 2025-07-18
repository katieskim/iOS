//
//  User.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/17/25.
//

import SwiftUI
import Foundation
import SwiftData

@Model
class UserEntity {
    @Attribute(.unique) var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    @Relationship(deleteRule: .cascade) var friends: [FriendEntity]

    init(from user: User) {
        self.id = user.id
        self.isActive = user.isActive
        self.name = user.name
        self.age = user.age
        self.company = user.company
        self.email = user.email
        self.address = user.address
        self.about = user.about
        self.friends = user.friends.map { FriendEntity(from: $0) }
    }

    func toUser() -> User {
        return User(
            id: id,
            isActive: isActive,
            name: name,
            age: age,
            company: company,
            email: email,
            address: address,
            about: about,
            friends: friends.map { $0.toFriend() }
        )
    }
}

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let friends: [Friend]
}
