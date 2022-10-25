//
//  ViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MainViewModel.counter = -1
    }

}
