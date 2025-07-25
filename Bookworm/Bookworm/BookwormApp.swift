//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Katie Kim on 7/16/25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
