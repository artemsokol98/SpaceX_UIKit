//
//  LoadingIndicatorView.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 16.09.2022.
//

import UIKit

class LoadingIndicatorView: UIView {

    static let shared = LoadingIndicatorView()
    
    func showLoading(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }

}
