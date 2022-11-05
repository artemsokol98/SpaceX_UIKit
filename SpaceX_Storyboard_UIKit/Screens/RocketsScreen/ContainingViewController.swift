//
//  ContainingViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 07.09.2022.
//

import UIKit

class ContainingViewController: UIViewController {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerImageHeight: NSLayoutConstraint!
    @IBOutlet weak var headerImageTop: NSLayoutConstraint!
    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    
    var maxScrollAmount: CGFloat {
        let expandedHeight = UIScreen.main.bounds.height / 2
        let collapsedHeight = containerViewTop.constant
        return expandedHeight - collapsedHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(sendRequest), name: Notification.Name(NotificationNames.dataDownloaded), object: nil)
        if let scrollView = containerView.subviews.first?.subviews.first as? UIScrollView { // subviews.first is a view of containerView. Next subviews.first is a tableView of view inside.
            
            // adjust the scroll view's top inset to account for scrolling the header offscreen
            scrollView.contentInset = UIEdgeInsets(top: maxScrollAmount, left: 0, bottom: 0, right: 0)
            scrollView.contentOffset = CGPoint(x: 0, y: -maxScrollAmount)
        }
        
        if var scrollViewContained = children.first as? ScrollViewContained {
            scrollViewContained.scrollDelegate = self
        }
        view.backgroundColor = .black
        if MainViewController.canIFetchData {
            sendRequest()
        }
    }
    
    @objc func sendRequest() {
        DispatchQueue.global().async {
            guard let url = URL(string:                            DIContainer.shared.networkManager.rocketModel[MainViewModel.counter].flickrImages?[0] ?? "No info") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.headerImage.image = UIImage(data: imageData)
            }
        }
    }
}

extension ContainingViewController: ScrollViewContainingDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newTopConstraintConstant = -(scrollView.contentOffset.y + maxScrollAmount / 1.2)
        headerImageTop.constant = -min(0, newTopConstraintConstant)
    }
    
}
