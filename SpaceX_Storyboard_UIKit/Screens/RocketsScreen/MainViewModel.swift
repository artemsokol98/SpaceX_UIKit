//
//  MainViewModel.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 13.09.2022.
//

import Foundation

protocol MainViewModelProtocol {
    var titleName: String { get set }
    var horizontalScrollViewModel: [TileCollectionViewCellViewModel] { get set }
    var firstSection: [MainInfoTVCModel] { get set }
    var firstStage: [MainInfoTVCModel] { get set }
    var secondStage: [MainInfoTVCModel] { get set }
    func fetchData(completion: @escaping () -> Void)
    var numberOfPage: Int { get }
}

class MainViewModel: MainViewModelProtocol {
    
    static var counter = -1 {
        didSet {
            print("MainViewModel counter \(counter)")
        }
    }
    let numberOfPage: Int
    
    init() {
        MainViewModel.counter += 1
        numberOfPage = MainViewModel.counter
        NotificationCenter.default.addObserver(self, selector: #selector(updateSetting(_:)), name: Notification.Name(NotificationNames.sendSettingData), object: nil)
    }
    
    func fetchData(completion: @escaping () -> Void) {
        self.horizontalScrollViewModel = []
        let rocketData =  DIContainer.shared.networkManager.rocketModel[numberOfPage]
        for item in 0...3 {
            let setting = DIContainer.shared.settingsManager.loadSetting(row: item)
            var secondaryLabel = ""
            switch item {
            case 0:
                if setting.currentSetting == 0 {
                    secondaryLabel = rocketData.height?.meters.map { String($0) } ?? MainViewModel.defaultValue
                } else {
                    secondaryLabel = rocketData.height?.feet.map { String($0) } ?? MainViewModel.defaultValue
                }
            case 1:
                if setting.currentSetting == 0 {
                    secondaryLabel = rocketData.diameter?.meters.map { String($0) } ?? MainViewModel.defaultValue
                } else {
                    secondaryLabel = rocketData.diameter?.feet.map { String($0) } ?? MainViewModel.defaultValue
                }
            case 2:
                if setting.currentSetting == 0 {
                    secondaryLabel = rocketData.mass?.kg.map { String($0) } ?? MainViewModel.defaultValue
                } else {
                    secondaryLabel = rocketData.mass?.lb.map { String($0) } ?? MainViewModel.defaultValue
                }
            case 3:
                if setting.currentSetting == 0 {
                    secondaryLabel = rocketData.payloadWeights?[0].kg.map { String($0) } ?? MainViewModel.defaultValue
                } else {
                    secondaryLabel = rocketData.payloadWeights?[0].lb.map { String($0) } ?? MainViewModel.defaultValue
                }
            default: fatalError()
            }
            self.horizontalScrollViewModel.append(
                TileCollectionViewCellViewModel(
                    label: setting.label,
                    secondaryLabel: secondaryLabel
                ))
        }
        
        // MARK: - Horizontal scroll view model
        
        self.titleName = DIContainer.shared.networkManager.rocketModel[numberOfPage].name ?? MainViewModel.defaultValue
        
        // MARK: - First secton
        self.firstSection = [
            MainInfoTVCModel(description: "First flight", value: DIContainer.shared.networkManager.rocketModel[numberOfPage].firstFlight ?? MainViewModel.defaultValue),
            MainInfoTVCModel(description: "Country", value: DIContainer.shared.networkManager.rocketModel[numberOfPage].country ?? MainViewModel.defaultValue),
            MainInfoTVCModel(description: "Cost per launch", value: {
                guard let costPerLaunch = DIContainer.shared.networkManager.rocketModel[numberOfPage].costPerLaunch else { return MainViewModel.defaultValue }
                let costPerLaunchInMln = Float(costPerLaunch / 1_000_000 )
                return String(costPerLaunchInMln)
            }()
                            )
        ]
        
        // MARK: - First stage
        self.firstStage = [
            MainInfoTVCModel(description: "Engines", value: DIContainer.shared.networkManager.rocketModel[numberOfPage].firstStage?.engines.map { String($0) } ?? MainViewModel.defaultValue),
            MainInfoTVCModel(description: "Fuel amount", value: DIContainer.shared.networkManager.rocketModel[numberOfPage].firstStage?.fuelAmountTons.map { String($0) } ?? MainViewModel.defaultValue),
            MainInfoTVCModel(description: "Burn time", value: DIContainer.shared.networkManager.rocketModel[numberOfPage].firstStage?.burnTimeSec.map { String($0) } ?? MainViewModel.defaultValue)
        ]
        
        // MARK: - Second stage
        self.secondStage = [
            MainInfoTVCModel(description: "Engines", value: DIContainer.shared.networkManager.rocketModel[numberOfPage].secondStage?.engines.map { String($0) } ?? MainViewModel.defaultValue),
            MainInfoTVCModel(description: "Fuel amount", value: DIContainer.shared.networkManager.rocketModel[numberOfPage].secondStage?.fuelAmountTons.map { String($0) } ?? MainViewModel.defaultValue),
            MainInfoTVCModel(description: "Burn time", value: DIContainer.shared.networkManager.rocketModel[numberOfPage].secondStage?.burnTimeSec.map { String($0) } ?? MainViewModel.defaultValue)
        ]
        completion()
    }
    
    static let defaultValue = "No info"
    
    var titleName = ""
    
    // MARK: - Title
    
    // MARK: - Horizontal scroll view model
    
    var horizontalScrollViewModel: [TileCollectionViewCellViewModel] = [
        TileCollectionViewCellViewModel(
            label: "Height",
            secondaryLabel: MainViewModel.defaultValue
        ),
        TileCollectionViewCellViewModel(
            label: "Diameter",
            secondaryLabel: MainViewModel.defaultValue
        ),
        TileCollectionViewCellViewModel(
            label: "Weight",
            secondaryLabel: MainViewModel.defaultValue
        ),
        TileCollectionViewCellViewModel(
            label: "Payload weight",
            secondaryLabel: MainViewModel.defaultValue
        )
        ]
    
    // MARK: - First secton
    
    var firstSection: [MainInfoTVCModel] = [
        MainInfoTVCModel(description: "First flight", value: MainViewModel.defaultValue),
        MainInfoTVCModel(description: "Country", value: MainViewModel.defaultValue),
        MainInfoTVCModel(description: "Cost per launch", value: MainViewModel.defaultValue)
    ]

    // MARK: - First stage
    
    var firstStage: [MainInfoTVCModel] = [
        MainInfoTVCModel(description: "Engines", value: MainViewModel.defaultValue),
        MainInfoTVCModel(description: "Fuel amount", value: MainViewModel.defaultValue),
        MainInfoTVCModel(description: "Burn time", value: MainViewModel.defaultValue)
    ]

    // MARK: - Second stage
    
    var secondStage: [MainInfoTVCModel] = [
        MainInfoTVCModel(description: "Engines", value: MainViewModel.defaultValue),
        MainInfoTVCModel(description: "Fuel amount", value: MainViewModel.defaultValue),
        MainInfoTVCModel(description: "Burn time", value: MainViewModel.defaultValue)
    ]
 
    @objc func updateSetting(_ notification: Notification) {
        guard let dict = notification.userInfo as Dictionary? else { return }
        guard let id = dict["row"] as? Int else { return }
        let setting = DIContainer.shared.settingsManager.loadSetting(row: id) 
        let rocketData = DIContainer.shared.networkManager.rocketModel[numberOfPage]
        var secondaryLabel = ""
        switch id {
        case 0:
            if setting.currentSetting == 0 {
                secondaryLabel = rocketData.height?.meters.map { String($0) } ?? MainViewModel.defaultValue
            } else {
                secondaryLabel = rocketData.height?.feet.map { String($0) } ?? MainViewModel.defaultValue
            }
        case 1:
            if setting.currentSetting == 0 {
                secondaryLabel = rocketData.diameter?.meters.map { String($0) } ?? MainViewModel.defaultValue
            } else {
                secondaryLabel = rocketData.diameter?.feet.map { String($0) } ?? MainViewModel.defaultValue
            }
        case 2:
            if setting.currentSetting == 0 {
                secondaryLabel = rocketData.mass?.kg.map { String($0) } ?? MainViewModel.defaultValue
            } else {
                secondaryLabel = rocketData.mass?.lb.map { String($0) } ?? MainViewModel.defaultValue
            }
        case 3:
            if setting.currentSetting == 0 {
                secondaryLabel = rocketData.payloadWeights?[0].kg.map { String($0) } ?? MainViewModel.defaultValue
            } else {
                secondaryLabel = rocketData.payloadWeights?[0].lb.map { String($0) } ?? MainViewModel.defaultValue
            }
        default: fatalError()
        }
        self.horizontalScrollViewModel[id].secondaryLabel = secondaryLabel
        
        NotificationCenter.default.post(name: Notification.Name(NotificationNames.settingChanged), object: nil)
    }
     
}
