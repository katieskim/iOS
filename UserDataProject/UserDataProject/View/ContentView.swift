//
//  ContentView.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/16/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = UsersViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error")
                            .font(.headline)
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task {
                                await viewModel.refreshUsers()
                            }
                        }
                    }
                } else {
                    UserListView(users: viewModel.users)
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        Task {
                            await viewModel.refreshUsers()
                        }
                    }
                }
            }
            .task {
                viewModel.setModelContext(modelContext)
                await viewModel.loadUsers()
            }
        }
    }
}

#Preview {
    ContentView()
}
