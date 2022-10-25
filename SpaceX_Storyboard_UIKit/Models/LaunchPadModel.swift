//
//  LaunchPadModel.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 11.10.2022.
//

import Foundation

struct LaunchPadModel: Decodable {
    let images: Images
    let name, fullName, locality, region: String
    let latitude, longitude: Double
    let launchAttempts, launchSuccesses: Int
    let rockets: [String]
    let timezone: String
    let launches: [String]
    let status, details, id: String

    enum CodingKeys: String, CodingKey {
        case images, name
        case fullName = "full_name"
        case locality, region, latitude, longitude
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
        case rockets, timezone, launches, status, details, id
    }
}

struct Images: Decodable {
    let large: [String]
}
