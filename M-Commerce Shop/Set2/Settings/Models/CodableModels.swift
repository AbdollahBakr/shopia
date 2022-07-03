//
//  CodableModels.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation

// MARK: - DataClass
struct DataClass: Codable {
    let customer: Customer?
    let draftOrder: DraftOrder?
}

// MARK: - Address
struct Address: Codable {
    let country, city, address1, address2: String?
}

// MARK: - CustomerUpdate
struct CustomerUpdate: Codable {
    let userErrors: [UserError]?
}

// MARK: - UserError
struct UserError: Codable {
    let field: [String]?
    let message: String?
}
