//
//  AddAddressModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 03/07/2022.
//

import Foundation

struct AddAddressModel: Codable {
    var input: AddAddressInput
}


struct AddAddressInput: Codable {
    var id: String
    var addresses: [Address]
}
