//
//  RocketModel.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 17.08.2022.
//

struct RocketModel: Decodable {
    let height: HeightAndDiameter?
    let diameter: HeightAndDiameter?
    let mass: Mass?
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    let engines: Engines?
    let landingLegs: LandingLegs?
    let payloadWeights: [PayloadWeight]?
    let flickrImages: [String]?
    let name: String?
    let type: String?
    let active: Bool?
    let stages: Int?
    let boosters: Int?
    let costPerLaunch: Int?
    let successRatePct: Int?
    let firstFlight: String?
    let country: String?
    let company: String?
    let wikipedia: String?
    let description: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegs = "landing_legs"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name, type, active, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, wikipedia, description, id
    }
}

struct HeightAndDiameter: Decodable {
    let meters: Double?
    let feet: Double?
}

struct Mass: Decodable {
    let kg: Int?
    let lb: Int?
}

struct FirstStage: Decodable {
    let thrustSeaLevel: Thrust?
    let thrustVacuum: Thrust?
    let reusable: Bool?
    let engines: Int?
    let fuelAmountTons: Double?
    let burnTimeSec: Int?
    
    private enum CodingKeys: String, CodingKey {
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

struct Thrust: Decodable {
    let kN: Int?
    let lbf: Int?
}

struct SecondStage: Decodable {
    let thrust: Thrust?
    let payloads: Payloads?
    let reusable: Bool?
    let engines: Int?
    let fuelAmountTons: Double?
    let burnTimeSec: Int?
    
    enum CodingKeys: String, CodingKey {
        case thrust, payloads, reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

struct Payloads: Decodable {
    let compositeFairing: CompositeFairing?
    let option1: String?
    
    enum CodingKeys: String, CodingKey {
        case compositeFairing = "composite_fairing"
        case option1 = "option_1"
    }
}

struct CompositeFairing: Decodable {
    let height: HeightAndDiameter?
    let diameter: HeightAndDiameter?
}

struct Engines: Decodable {
    let isp: ISP?
    let thrustSeaLevel, thrustVacuum: Thrust?
    let number: Int?
    let type, version: String?
    let layout: String?
    let engineLossMax: Int?
    let propellant1, propellant2: String?
    let thrustToWeight: Double?

    enum CodingKeys: String, CodingKey {
        case isp
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case number, type, version, layout
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustToWeight = "thrust_to_weight"
    }
}

struct LandingLegs: Decodable {
    let number: Int?
    let material: String?
}

struct PayloadWeight: Decodable {
    let id: String?
    let name: String?
    let kg: Int?
    let lb: Int?
}

struct ISP: Decodable {
    let seaLevel: Int?
    let vacuum: Int?

    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case vacuum
    }
}




