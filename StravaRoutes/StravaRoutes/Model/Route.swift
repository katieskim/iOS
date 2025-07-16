//
//  Route.swift
//  StravaRoutes
//
//  Created by Katie Kim on 7/16/25.
//  Copyright © 2025 Strava. All rights reserved.
//

import Foundation
import SwiftUI

struct Route: Identifiable, Codable {
    let id: Int
    let mapURL: URL?
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

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case mapURL = "map_url"
        case name = "name"
        case distance = "distance"
        case elevationGain = "elevation_gain"
        case type = "type"
    }
}

