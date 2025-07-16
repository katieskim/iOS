//
//  RoutesView.swift
//  StravaRoutes
//
//  Created by Katie Kim on 7/16/25.
//  Copyright © 2025 Strava. All rights reserved.
//

import SwiftUI

struct RoutesFeedView: View {
    @ObservedObject var controller = RoutesViewController()

    var body: some View {
        NavigationStack {
            Group {
                if controller.isLoading {
                    ProgressView("Loading routes...")
                } else if let errorMessage = controller.errorMessage {
                    Text(errorMessage)
                } else {
                    List(controller.routes) { route in
                        RouteView(route: route)
                    }
                }
            }
            .navigationTitle("Routes")
            .task {
                do {
                    try await controller.fetchRoutes()
                } catch {
                    print("Error fetching routes")
                }
            }
        }
    }
}

#Preview {
    RoutesFeedView(controller: RoutesViewController())
}

