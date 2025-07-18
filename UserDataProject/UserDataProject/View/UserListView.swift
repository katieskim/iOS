//
//  UserListView.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/17/25.
//

import SwiftUI

struct UserListView: View {
    let users: [User]

    var body: some View {
        List(users) { user in
            NavigationLink(destination: UserDetailView(user:user)) {
                UserRowView(user: user)
            }
        }
    }
}
