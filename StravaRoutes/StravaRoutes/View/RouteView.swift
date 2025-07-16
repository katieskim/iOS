//
//  RouteView.swift
//  StravaRoutes
//
//  Created by Katie Kim on 7/16/25.
//  Copyright © 2025 Strava. All rights reserved.
//

import Foundation
import SwiftUI

struct RouteView: View {
    let route: Route
    @State var image: UIImage?

    var body: some View {
        VStack(alignment: .leading) {
            Text(route.name)
                .font(.title2)
                .padding(.bottom, 3)

            HStack(alignment: .top, spacing: 20) {
                Text("Distance: \(route.distanceInMiles)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Elevation: \(route.elevationInFeet)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

            }

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            do {
                image = try await loadImage()
            } catch {
                print("Error loading image.")
            }
        }
    }

    func loadImage() async throws -> UIImage? {
        guard let url = route.mapURL else { return nil }
        image = try await StravaRoutes.loadImage(from: url)
        return image
    }
}

#Preview {
    RouteView(route: Route(id: 2735025266296229722, mapURL: URL("https://d3o5xota0a1fcr.cloudfront.net/maps/RFWF5B76SMZYKXF2KX7POI4EHIA4BSHVBC4ZHHIBWG7HT77NA7YYCZVQUWPR2L7KYX357UJULG3JIARM2U6MDNEENE4BTUNQROHA====") ?? nil, name: "Marin Sunday Run", distance: 14235.319099149601, elevationGain: 499.08645046007325, type: 2))
}
