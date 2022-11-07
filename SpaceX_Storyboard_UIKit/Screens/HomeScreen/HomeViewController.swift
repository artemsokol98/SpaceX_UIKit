//
//  HomeViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 06.10.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle(Texts.homeScreenOpenButton, for: .normal)
        button.addTarget(self, action: #selector(openMainViewController), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(alertControllerForInfo), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: UIButton = { // another one in title in viewcontroller with rockets, maybe combine together
        let button = UIButton()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .medium)
        let SFSymbol = UIImage(systemName: "gearshape", withConfiguration: symbolConfiguration)
        button.setImage(SFSymbol, for: .normal)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.homeScreenIntroLabel
        label.font = UIFont(name: Fonts.homeScreenFontHelveticaBold, size: 20)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(infoButton)
        view.addSubview(introLabel)
        view.addSubview(settingsButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        // MARK: - Button
        view.addConstraint(
            NSLayoutConstraint(item: button,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0)
        )
        
        view.addConstraint(
            NSLayoutConstraint(item: button,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerY,
                               multiplier: 1.5,
                               constant: 0)
        )
        
        view.addConstraint(
            NSLayoutConstraint(item: button,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .width,
                               multiplier: 0.5,
                               constant: 0)
        )
        
        view.addConstraint(
            NSLayoutConstraint(item: button,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .height,
                               multiplier: 0.1,
                               constant: 0)
        )
        // MARK: - Info button
        
        view.addConstraint(
            NSLayoutConstraint(item: infoButton,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1.8,
                               constant: 0)
        )
        view.addConstraint(
            NSLayoutConstraint(item: infoButton,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerY,
                               multiplier: 0.2,
                               constant: 0)
        )
        // MARK: - Intro label
        view.addConstraint(
            NSLayoutConstraint(item: introLabel,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0)
        )
        
        view.addConstraint(
            NSLayoutConstraint(item: introLabel,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0)
        )
        
        // MARK: - Settings button
        view.addConstraint(
            NSLayoutConstraint(item: settingsButton,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 0.2,
                               constant: 0)
        )
        view.addConstraint(
            NSLayoutConstraint(item: settingsButton,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerY,
                               multiplier: 0.2,
                               constant: 0)
        )
    }
    
    @objc func openMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.initialRocketsViewController)
        // TODO: - remove duplicates
        vc.title = Texts.mainViewControllerTitle
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Texts.mainViewControllerLeftBarButtonItem, style: .plain, target: self, action: #selector(closeNavVC))
        let navCon = UINavigationController(rootViewController: vc)
        navCon.navigationBar.isTranslucent = false
        navCon.modalPresentationStyle = .fullScreen
        navCon.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.present(navCon, animated: true)
    }
    
    @objc func closeNavVC() {
        dismiss(animated: true)
        MainViewModel.counter = -1
    }
    
    @objc func alertControllerForInfo() {
        let alert = UIAlertController(title: Texts.alertActionTitle, message: Texts.alertControllerMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Texts.alertActionTitle, style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func settingsButtonPressed() {
        let settingsVC = SettingsViewController()
        let navCon = UINavigationController(rootViewController: settingsVC)
        navCon.navigationBar.backgroundColor = .black
        navCon.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navCon.navigationBar.tintColor = .white
        navCon.navigationBar.barStyle = .black
        navCon.modalPresentationStyle = .pageSheet
        self.present(navCon, animated: true)
    }

}
