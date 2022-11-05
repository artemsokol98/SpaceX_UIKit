//
//  DIContainer.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 05.11.2022.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    
    lazy var networkManager = NetworkManager()
    
    lazy var settingsManager = SettingsManager()
}
