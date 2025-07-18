//
//  Route.swift
//  StravaRoutes
//
//  Created by Katie Kim on 7/17/25.
//  Copyright © 2025 Strava. All rights reserved.
//
import SwiftUI
import SwiftData

struct Route: Codable, Identifiable {
    let id: Int
    let mapUrl: String
    let name: String
    let distance: Double
    let elevationGain: Double
    let type: Int

    var distanceInMiles: String {
        ImperialFormatter.string(forDistance: distance)
    }

    var elevationInFeet: String {
        ImperialFormatter.string(forElevation: elevationGain)
    }

    var activityString: String {
        if type == 1 { return "Ride" } else if type == 2 { return "Run"} else { return "Other acivity"}
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case mapUrl = "map_url"
        case name = "name"
        case distance = "distance"
        case elevationGain = "elevation_gain"
        case type = "type"
    }
}
