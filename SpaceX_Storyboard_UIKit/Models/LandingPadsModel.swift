//
//  LandingPadsModel.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 11.10.2022.
//

import Foundation

struct LandingPadModel: Decodable {
    let images: Images
    let name, fullName, status, type: String
    let locality, region: String
    let latitude, longitude: Double
    let landingAttempts, landingSuccesses: Int
    let wikipedia: String
    let details: String
    let launches: [String]
    let id: String

    enum CodingKeys: String, CodingKey {
        case images, name
        case fullName = "full_name"
        case status, type, locality, region, latitude, longitude
        case landingAttempts = "landing_attempts"
        case landingSuccesses = "landing_successes"
        case wikipedia, details, launches, id
    }
}
