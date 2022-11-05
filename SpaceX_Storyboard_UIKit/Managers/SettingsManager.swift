//
//  SettingsManager.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 24.09.2022.
//

import Foundation

class SettingsManager {
    var settings = [EnumirationCurrentSettings]()
    
    func loadDefaultSettings() {
        // SettingsManager.shared.
        settings.append(EnumirationCurrentSettings.height(.meter))
        if defaults.object(forKey: "Height") == nil {
            defaults.set(
                0,
                forKey: "Height"
            )
        }
        // SettingsManager.shared.
        settings.append(EnumirationCurrentSettings.diameter(.meter))
        if defaults.object(forKey: "Diameter") == nil {
            defaults.set(
                0,
                forKey: "Diameter"
            )
        }
        // SettingsManager.shared.
        settings.append(EnumirationCurrentSettings.weight(.kilogramm))
        if defaults.object(forKey: "Weight") == nil {
            defaults.set(
                0,
                forKey: "Weight"
            )
        }
        // SettingsManager.shared.
        settings.append(EnumirationCurrentSettings.payload(.kilogrammm))
        if defaults.object(forKey: "Payload") == nil {
            defaults.set(
                0,
                forKey: "Payload"
            )
        }
        
    }
    
    func loadSetting(row: Int) -> ReturnedCurrentSetting {
        // SettingsManager.shared.
        if settings.isEmpty {
            loadDefaultSettings()
        }
        var arrayOfDescription = [String]()
        var currentSettingIndex = Int()
        switch row {
        case 0:
            // SettingsManager.shared.
            for item in settings[row].casesHeight {
                arrayOfDescription.append(item.description)
            }
            currentSettingIndex = defaults.integer(forKey: "Height")
            
        case 1:
            // SettingsManager.shared.
            for item in settings[row].casesDiameter {
                arrayOfDescription.append(item.description)
            }
            currentSettingIndex = defaults.integer(forKey: "Diameter")
            
        case 2:
            // SettingsManager.shared.
            for item in settings[row].casesWeight {
                arrayOfDescription.append(item.description)
            }
            currentSettingIndex = defaults.integer(forKey: "Weight")
            
        case 3:
            // SettingsManager.shared.
            for item in settings[row].casesPayload {
                arrayOfDescription.append(item.description)
            }
            currentSettingIndex = defaults.integer(forKey: "Payload")
            
        default: print("exhaustive load setting"); fatalError()
        }
        
        return ReturnedCurrentSetting(
            // SettingsManager.shared.
            label: settings[row].label,
            currentSetting: currentSettingIndex,
            descriptions: arrayOfDescription
        )
    }
    
    let defaults = UserDefaults.standard
    // вынести константы в отдельный класс под static элементами

    func setSetting(numberOfSegmentedControl: Int, key label: String) {
        
        defaults.set(
            numberOfSegmentedControl,
            forKey: label
        )
        
        var data: [String: Int] = [:]
        // SettingsManager.shared.
        for item in 0...3 where settings[item].label == label {
                data = ["row": item]
            }
        
        NotificationCenter.default.post(name: Notification.Name(NotificationNames.sendSettingData), object: nil, userInfo: data)
    }
    
}

struct ReturnedCurrentSetting {
    var label: String
    var currentSetting: Int
    var descriptions: [String]
}

enum EnumirationCurrentSettings {
    case height(Height)
    case diameter(Diameter)
    case weight(Weight)
    case payload(Payload)
    
    var label: String {
        switch self {
        case .height(let height):
            return height.label
        case .diameter(let diameter):
            return diameter.label
        case .weight(let weight):
            return weight.label
        case .payload(let payload):
            return payload.label
        }
    }
    
    var description: String {
        switch self {
        case .height(let height):
            return height.description
        case .diameter(let diameter):
            return diameter.description
        case .weight(let weight):
            return weight.description
        case .payload(let payload):
            return payload.description
        }
    }
    
    var currentValue: Int {
        switch self {
        case .height(let height):
            return height.rawValue
        case .diameter(let diameter):
            return diameter.rawValue
        case .weight(let weight):
            return weight.rawValue
        case .payload(let payload):
            return payload.rawValue
        }
    }
    
    var casesHeight: [Height] {
        return Height.allCases
    }
    
    var casesDiameter: [Diameter] {
        return Diameter.allCases
    }
    
    var casesWeight: [Weight] {
        return Weight.allCases
    }
    
    var casesPayload: [Payload] {
        return Payload.allCases
    }
}

enum Height: Int, CaseIterable {
    case meter
    case feet
    
    var description: String {
        switch self {
        case .meter:
            return "m"
        case .feet:
            return "ft"
        }
    }
    
    var cases: [Height] {
        return Height.allCases
    }
    var label: String {
        return "Height"
    }
}

enum Diameter: Int, CaseIterable {
    case meter
    case feet
    
    var description: String {
        switch self {
        case .meter:
            return "m"
        case .feet:
            return "ft"
        }
    }
    
    var cases: [Diameter] {
        return Diameter.allCases
    }
    
    var label: String {
        return "Diameter"
    }
}

enum Weight: Int, CaseIterable {
    case kilogramm
    case pounds
    
    var description: String {
        switch self {
        case .kilogramm:
            return "kg"
        case .pounds:
            return "lb"
        }
    }
    
    var cases: [Weight] {
        return Weight.allCases
    }
    
    var label: String {
        return "Weight"
    }
}

enum Payload: Int, CaseIterable {
    case kilogrammm
    case pounds
    
    var description: String {
        switch self {
        case .kilogrammm:
            return "kg"
        case .pounds:
            return "lb"
        }
    }
    
    var cases: [Payload] {
        return Payload.allCases
    }
    
    var label: String {
        return "Payload"
    }
}
