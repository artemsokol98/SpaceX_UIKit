//
//  MainViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 07.09.2022.
//

import UIKit

protocol ScrollViewContainingDelegate: NSObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

protocol ScrollViewContained {
    var scrollDelegate: ScrollViewContainingDelegate? { get set }
}

class MainViewController: UIViewController, ScrollViewContained {
    
    var viewModel: MainViewModelProtocol!
    
    static var canIFetchData = false
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        table.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        table.register(HeaderInfoTableViewSection.self, forHeaderFooterViewReuseIdentifier: HeaderInfoTableViewSection.identifier)
        table.register(HeaderTitleTableViewSection.self, forHeaderFooterViewReuseIdentifier: HeaderTitleTableViewSection.identifier)
        table.register(ShowLaunchesButtonTableViewCell.self, forCellReuseIdentifier: ShowLaunchesButtonTableViewCell.identifier)
        return table
    }()
    
    weak var scrollDelegate: ScrollViewContainingDelegate?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(sendRequest), name: Notification.Name(NotificationNames.dataDownloaded), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateInfo), name: Notification.Name(NotificationNames.settingChanged), object: nil)
        viewModel = MainViewModel()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        if MainViewController.canIFetchData {
            sendRequest()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func sendRequest() {
        MainViewController.canIFetchData = true
        viewModel?.fetchData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("data fetched")
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderInfoTableViewSection.identifier) as? HeaderInfoTableViewSection else { fatalError() }
        guard let titleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTitleTableViewSection.identifier) as? HeaderTitleTableViewSection else { fatalError() }
        
        switch section {
        case 0:
            titleView.headerTitleButtonCellDelegate = self
            titleView.configure(with: self.viewModel.titleName)
            return titleView
        case 1: view.configure(with: Texts.firstSectionName)
        case 2: view.configure(with: Texts.secondSectionName)
        default: fatalError()
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.section == 0 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else { fatalError() }
            cell.configure(with: viewModel.horizontalScrollViewModel)
                return cell
        } else if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else { fatalError() }
            cell.configure(viewModel: viewModel.firstSection[indexPath.row - 1]) // magic number "1", because first row is horizontal scroll
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else { fatalError() }
            cell.configure(viewModel: viewModel.firstStage[indexPath.row])
            return cell
        }
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowLaunchesButtonTableViewCell.identifier, for: indexPath) as? ShowLaunchesButtonTableViewCell else { fatalError() }
                cell.showLaunchesButtonCellDelegate = self
                return cell
        }
        
        if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else { fatalError() }
            cell.configure(viewModel: viewModel.secondStage[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        if section == 1 {
            return viewModel.firstStage.count
        }
        if section == 2 {
            return viewModel.secondStage.count + 1 // 1 is an orange button
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return view.frame.size.width * 0.5
        } else {
            return view.frame.size.width * 0.2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    @objc func updateInfo() {
        tableView.reloadData()
    }
}

extension MainViewController: ShowLaunchesButtonCellDelegate {
    func didPressButton() {
        let vc = LaunchesViewController(launches: NetworkManager.shared.rocketLaunches, rocketId: NetworkManager.shared.rocketModel[viewModel.numberOfPage].id)
        vc.accessibilityNavigationStyle = .automatic
        show(vc, sender: self)
        vc.navigationItem.title = NetworkManager.shared.rocketModel[viewModel.numberOfPage].name
        vc.navigationItem.titleView?.tintColor = .black
    }
}

extension MainViewController: HeaderTitleCellDelegate {
    func settingsButtonDidPressed() {
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
