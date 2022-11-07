//
//  LaunchesViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 23.09.2022.
//

import UIKit

class LaunchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .null, style: .insetGrouped)
        table.register(LaunchesTableViewCell.self, forCellReuseIdentifier: LaunchesTableViewCell.identifier)
        table.backgroundColor = .black
        return table
    }()
    
    init(launches: [RocketLaunches], rocketId: String?) {
        super.init(nibName: nil, bundle: nil)
        for launch in launches where launch.rocket == rocketId {
                self.viewModel.append(LaunchesViewModel(
                    name: launch.name ?? "No info",
                    date: launch.dateLocal ?? "No info",
                    success: launch.success ?? false)
                )
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: [LaunchesViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.identifier, for: indexPath) as? LaunchesTableViewCell else { fatalError() }
        cell.configure(with: viewModel[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height * 0.15
    }

}
