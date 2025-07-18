//
//  UserDataProjectApp.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/16/25.
//

import SwiftUI

@main
struct UserDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [UserEntity.self, FriendEntity.self])
    }
}
