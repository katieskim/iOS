//
//  NetworkManager.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/17/25.
//

import SwiftUI
import Foundation

class NetworkManager {
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode([User].self, from: data)
        return users
    }
}

