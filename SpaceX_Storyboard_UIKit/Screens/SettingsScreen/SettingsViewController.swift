//
//  SettingsViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 24.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()
    
    private let stackView = UIStackView()
    
    @objc func closeVC() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        // TODO: remove duplicate titles and bar button definitions
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Texts.settingScreenRightBarButtonItem, style: .plain, target: self, action: #selector(closeVC))
        navigationItem.title = Texts.settingScreenNavigationTitle
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 56, width: view.bounds.width, height: view.bounds.height)
        
    }

}

extension SettingsViewController: UITableViewDelegate {
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { fatalError() }
        cell.segmentedControlValueChangedDelegate = self
        cell.configure(infoForSegmentedControl: DIContainer.shared.settingsManager.loadSetting(row: indexPath.row))
        cell.backgroundColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

extension SettingsViewController: SegmentedControlDelegate {
    func segmentedControlValueChanged(SCIndex: Int, label: String) {
        DIContainer.shared.settingsManager.setSetting(numberOfSegmentedControl: SCIndex, key: label)
    }
}
