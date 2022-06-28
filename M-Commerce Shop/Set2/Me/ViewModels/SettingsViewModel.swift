//
//  SettingsViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import Foundation

class SettingsViewModel {
    
    static var settingsCells: [SettingsCell] = [
        SettingsCell(settingOption: "Address", settingValue: "Cairo"),
        SettingsCell(settingOption: "Currency", settingValue: "EGP"),
        SettingsCell(settingOption: "Contact us", settingValue: nil),
        SettingsCell(settingOption: "About us", settingValue: nil)
    ]
}
