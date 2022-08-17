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
}
/*
enum DataTypes {
    case rocketModel = RocketModel
    case rocketLaunces = RocketLaunches
}
*/
class NetworkManager {
    
    
    
    
    func fetchAPIinfo<T: Decodable>(urlString: String, expectingReturnType: T.Type) {
        guard let url = URL(string: urlString) else { return }
        //let config = URLSession(configuration: .default)
        //URLSessionConfiguration.default
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data, let response = response else { return }
            let jsonDecoder = JSONDecoder()
            guard let usefulData = try? jsonDecoder.decode([T].self, from: data) else { return }
            print(usefulData)
        }.resume()
    }
}
