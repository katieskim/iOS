//
//  RouteView.swift
//  StravaRoutes
//
//  Created by Katie Kim on 7/17/25.
//  Copyright © 2025 Strava. All rights reserved.
//
import SwiftUI

struct RouteView: View {
    let route: Route

    @State var image: UIImage? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text(route.name)
                .font(.title2)

            HStack(spacing: 20) {
                Text("Distance: \(route.distanceInMiles) mi")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Elevation: \(route.elevationInFeet) ft")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                
            }

            Text("Activity type: \(route.activityString)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .foregroundColor(.gray)
                    Text("No image found")
                        .fontWeight(.bold)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            guard let url = URL(string: route.mapUrl) else { return }
            do {
                image = try await loadImage(from: url)
            } catch {
                print("Error loading image.")
            }
        }
    }
}

#Preview {
    RouteView(route: Route(id: 2735025266296229722, mapUrl: "https://d3o5xota0a1fcr.cloudfront.net/maps/RFWF5B7MZYKXF2KX7POI4EHIA4BSHVBC4ZHHIBWG7HT77NA7YYCZVQUWPR2L7KYX357UJULG3JIARM2U6MDNEENE4BTUNQROHA====", name: "Marin Sunday Run", distance: 14235.319099149601, elevationGain: 499.08645046007325, type: 2))
}

