//
//  ContentView.swift
//  StravaRoutes
//
//  Created by Katie Kim on 7/17/25.
//  Copyright © 2025 Strava. All rights reserved.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RouteViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading routes...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error")
                            .font(.headline)
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                        Button("Refresh") {
                            Task {
                                await viewModel.loadRoutes()
                            }
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.displayedRoutes) { route in
                            RouteView(route: route)
                        }
                    }
                }

                if viewModel.hasMoreData {
                    Button("Show more") {
                        Task {
                            await viewModel.loadMoreUsers()
                        }
                    }
                }
            }
            .navigationTitle("All Routes")
            .task {
                await viewModel.loadRoutes()
            }
        }
    }
}

#Preview {
    ContentView()
}

