//
//  TabBarViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 10.10.2022.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.unselectedItemTintColor = .gray
        let tabOne = HomeViewController()
        let tabOneBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "star"), selectedImage: nil)
        tabOne.tabBarItem = tabOneBarItem
        let tabTwo = GoogleMapsViewController()
        let tabTwoBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), selectedImage: nil)
        tabTwo.tabBarItem = tabTwoBarItem
        self.viewControllers = [tabOne, tabTwo]
    }

}
