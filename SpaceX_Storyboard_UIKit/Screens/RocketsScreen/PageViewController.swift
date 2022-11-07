//
//  PageViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 07.09.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var networkManager: NetworkManagerProtocol!
    
    var items: [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        decoratePageControl()
        populateItems()
        view.backgroundColor = .black
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [PageViewController.self])
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
    }
    
    @objc func populateItems() {
        for _ in 0..<getCountOfPages() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let c = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.containingViewController) 
            self.items.append(c)
        }
    }
    
    func getCountOfPages() -> Int {
        DIContainer.shared.networkManager.rocketModel.count
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }

}
