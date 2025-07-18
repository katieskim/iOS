//
//  RouteViewModel.swift
//  StravaRoutes
//
//  Created by Katie Kim on 7/17/25.
//  Copyright © 2025 Strava. All rights reserved.
//

import SwiftUI
import SwiftData

@MainActor
class RouteViewModel: ObservableObject {
    @Published var displayedRoutes: [Route] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var hasMoreData = true

    private var allRoutes: [Route] = []
    private let pageSize = 3
    private var currentPage = 0

    private var isLoadingMore = false

    private let networkService = RoutesJSONLoader()

    private func loadInitialPage() {
        currentPage = 0
        displayedRoutes = Array(allRoutes.prefix(pageSize))
        hasMoreData = allRoutes.count > pageSize
    }

    func loadRoutes() async {
        guard allRoutes.isEmpty else { return }
        isLoading = true

        // call the fetch function
        do {
            let data = try await networkService.loadData()
            allRoutes = try JSONDecoder().decode([Route].self, from: data)
            loadInitialPage()
        } catch let error {
            errorMessage = "Failed to load routes: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func loadMoreUsers() async {
        guard hasMoreData && !isLoadingMore else { return }
        isLoadingMore = true

        let startIndex = (currentPage + 1) * pageSize
        let endIndex = min(startIndex + pageSize, allRoutes.count)

        if startIndex < allRoutes.count {
            let newRoutes = Array(allRoutes[startIndex..<endIndex])
            displayedRoutes.append(contentsOf: newRoutes)
            currentPage += 1
            hasMoreData = endIndex < allRoutes.count
        } else {
            hasMoreData = false
        }

        isLoadingMore = false
    }
}
