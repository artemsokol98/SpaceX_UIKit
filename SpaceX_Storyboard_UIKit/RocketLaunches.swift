//
//  RocketLaunches.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 17.08.2022.
//

import Foundation

struct RocketLaunches: Decodable {
    let fairings: Fairings?
    let links: Links?
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let net: Bool?
    let window: Int?
    let rocket: String?
    let success: Bool?
    let failures: [Failure]?
    let details: String?
    let crew, ships, capsules, payloads: [String]?
    let launchpad: String?
    let flightNumber: Int?
    let name, dateUTC: String?
    let dateUnix: Int?
    let dateLocal: String?
    let datePrecision: String?
    let upcoming: Bool?
    let cores: [Core]?
    let autoUpdate, tbd: Bool?
    let launchLibraryID: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case fairings, links
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case net, window, rocket, success, failures, details, crew, ships, capsules, payloads, launchpad
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming, cores
        case autoUpdate = "auto_update"
        case tbd
        case launchLibraryID = "launch_library_id"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print(container)
        fairings = try container.decode(Fairings?.self, forKey: .fairings)
        print(fairings)
        links = try container.decode(Links?.self, forKey: .links)
        print(links)
        staticFireDateUTC = try container.decode(String?.self, forKey: .staticFireDateUTC)
        print(staticFireDateUTC)
        staticFireDateUnix = try container.decode(Int?.self, forKey: .staticFireDateUnix)
        print(staticFireDateUnix)
        net = try container.decode(Bool?.self, forKey: .net)
        print(net)
        window = try container.decode(Int?.self, forKey: .window)
        print(window)
        rocket = try container.decode(String?.self, forKey: .rocket)
        print(rocket)
        success = try container.decode(Bool?.self, forKey: .success)
        print(success)
        failures = try container.decode([Failure]?.self, forKey: .failures)
        print(failures)
        details = try container.decode(String?.self, forKey: .details)
        print(details)
        crew = try container.decode([String]?.self, forKey: .crew)
        print(crew)
        ships = try container.decode([String]?.self, forKey: .ships)
        print(ships)
        capsules = try container.decode([String]?.self, forKey: .capsules)
        print(capsules)
        payloads = try container.decode([String]?.self, forKey: .payloads)
        print(payloads)
        launchpad = try container.decode(String?.self, forKey: .launchpad)
        print(launchpad)
        flightNumber = try container.decode(Int?.self, forKey: .flightNumber)
        print(flightNumber)
        name = try container.decode(String?.self, forKey: .name)
        print(name)
        dateUTC = try container.decode(String?.self, forKey: .dateUTC)
        print(dateUTC)
        dateUnix = try container.decode(Int?.self, forKey: .dateUnix)
        print(dateUnix)
        dateLocal = try container.decode(String?.self, forKey: .dateLocal)
        print(dateLocal)
        datePrecision = try container.decode(String?.self, forKey: .datePrecision)
        print(datePrecision)
        upcoming = try container.decode(Bool?.self, forKey: .upcoming)
        print(upcoming)
        cores = try container.decode([Core]?.self, forKey: .cores)
        print(cores)
        autoUpdate = try container.decode(Bool?.self, forKey: .autoUpdate)
        print(autoUpdate)
        tbd = try container.decode(Bool?.self, forKey: .tbd)
        print(tbd)
        launchLibraryID = try container.decode(String?.self, forKey: .launchLibraryID)
        print(launchLibraryID)
        id = try container.decode(String?.self, forKey: .id)
        print(id)
        
    }
}

// MARK: - Fairings

struct Fairings: Decodable {
    let reused, recoveryAttempt, recovered: Bool?
    let ships: [String]?

    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt = "recovery_attempt"
        case recovered, ships
    }
}

// MARK: - Links
struct Links: Decodable {
    let patch: Patch?
    let reddit: Reddit?
    let flickr: Flickr?
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article: String?
    let wikipedia: String?

    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, presskit, webcast
        case youtubeID = "youtube_id"
        case article, wikipedia
    }
}

struct Patch: Decodable {
    let small, large: String?
}

struct Reddit: Decodable {
    let campaign: String?
    let launch: String?
    let media, recovery: String?
}

struct Flickr: Decodable {
    let small: [String]?
    let original: [String]?
}

//MARK: - Core
struct Core: Decodable {
    let core: String?
    let flight: Int?
    let gridfins, legs, reused, landingAttempt: Bool?
    let landingSuccess: Bool?
    let landingType: String?
    let landpad: String?

    enum CodingKeys: String, CodingKey {
        case core, flight, gridfins, legs, reused
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
        case landpad
    }
}

//MARK: - Failure
struct Failure: Decodable {
    let time: Int?
    let altitude: Int?
    let reason: String?
}


