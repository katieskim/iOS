//
//  UsersViewModel.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/17/25.
//
import Foundation
import SwiftUI
import SwiftData


@MainActor
class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let networkManager: NetworkManager
    private var modelContext: ModelContext?

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
        loadPersistedUsers()
    }

    private func loadPersistedUsers() {
        guard let context = modelContext else { return }

        do {
            let descriptor = FetchDescriptor<UserEntity>()
            let userEntities = try context.fetch(descriptor)
            users = userEntities.map { $0.toUser() }
        } catch {
            print("Failed to load persisted users: \(error)")
        }
    }

    private func persistUsers(_ users: [User]) async {
        guard let context = modelContext else { return }
        do {
            // clear existing data
            try context.delete(model: UserEntity.self)
            //save new data
            for user in users {
                let userEntity = UserEntity(from: user)
                context.insert(userEntity)
            }
            try context.save()
        } catch {
            print("Failed to persist users: \(error)")
        }
    }

    func refreshUsers() async {
        users = []
        await loadUsers()
    }

    func loadUsers() async {
        // if we have persisted data, don't fetch from the network
        guard users.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            users = try await networkManager.fetchUsers()
        } catch {
            errorMessage = "Failed to load users: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
