//
//  ViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        let networkManager = NetworkManager()
        networkManager.fetchAPIinfo(urlString: URLs.rocketModel.rawValue, expectingReturnType: RocketModel.self)
        networkManager.fetchAPIinfo(urlString: URLs.rocketLaunches.rawValue, expectingReturnType: RocketLaunches.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

