//
//  NetworkManager.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 17.08.2022.
//

import Foundation

enum URLs: String {
    case rocketModel = "https://api.spacexdata.com/v4/rockets"
    case rocketLaunches = "https://api.spacexdata.com/v4/launches"
    case launchPads = "https://api.spacexdata.com/v4/launchpads"
    case landingPads = "https://api.spacexdata.com/v4/landpads"
}

typealias CompletionHadler = () -> Void

protocol NetworkManagerProtocol {
    var rocketModel: [RocketModel] { get set }
    var rocketLaunches: [RocketLaunches] { get set }
    var launchPads: [LaunchPadModel] { get set }
    var landingPads: [LandingPadModel] { get set }
}

class NetworkManager: NetworkManagerProtocol {
    var landingPads: [LandingPadModel] = []
    var launchPads: [LaunchPadModel] = []
    var rocketModel: [RocketModel] = []
    var rocketLaunches: [RocketLaunches] = []
    
    func fetchInformation<T: Decodable>(urlString: String, expectingType: T.Type, completion: @escaping CompletionHadler) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                    switch expectingType {
                    case is [RocketModel].Type:
                        guard let rockets = decodedData as? [RocketModel] else { return }
                        self.rocketModel = rockets
                    case is [RocketLaunches].Type:
                        guard let launches = decodedData as? [RocketLaunches] else { return }
                        self.rocketLaunches = launches
                    case is [LaunchPadModel].Type:
                        guard let launchPads = decodedData as? [LaunchPadModel] else { return }
                        self.launchPads = launchPads
                    case is [LandingPadModel].Type:
                        guard let landingPads = decodedData as? [LandingPadModel] else { return }
                        self.landingPads = landingPads
                    default: fatalError("Wrong type")
                    }
                    completion()
                    return
                }
            }
            completion()
        }.resume()
    }
}
