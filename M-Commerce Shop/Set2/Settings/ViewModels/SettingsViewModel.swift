//
//  SettingsViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import Foundation

class SettingsViewModel {
    
    static var settingsCells: [SettingsCell] = [
        SettingsCell(settingOption: .address, settingValue: ""),
        SettingsCell(settingOption: .currency, settingValue: "EGP"),
        SettingsCell(settingOption: .contactUs, settingValue: nil),
        SettingsCell(settingOption: .aboutUs, settingValue: nil)
    ]
    
}

