//
//  SettingsCell.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import Foundation

struct SettingsCell {
    var settingOption: Setting
    var settingValue: String?
}


enum Setting: String {
    case address = "Address"
    case currency = "Currency"
    case contactUs = "Contact us"
    case aboutUs = "About us"
}
