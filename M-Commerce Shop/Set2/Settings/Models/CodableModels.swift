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


// MARK: - Customer
struct Customer: Codable {
    var id                      : String?
    var email                   : String?
    var firstName              : String?
    var lastName               : String?
//    var orders_count            : Int?
//    var total_spent             : String?
    var multipass_identifier    : String?
    var addresses               : [Address]?
    var numberOfOrders: String?
}

// MARK: - Address
struct Address: Codable, Equatable {
    let country, city, address1, address2: String?
    
    static func == (lhs: Address, rhs: Address) -> Bool {
        // LHS
        let lCountry = lhs.country
        let lCity = lhs.city
        let lAddress1 = lhs.address1
        let lAddress2 = lhs.address1
        // LHS
        let rCountry = rhs.country
        let rCity = rhs.city
        let rAddress1 = rhs.address1
        let rAddress2 = rhs.address1
        
        
        
        return (lCountry == rCountry && lCountry != nil && rCountry != nil
                && lCity == rCity && lCity != nil && rCity != nil
                && lAddress1 == rAddress1 && lAddress1 != nil && rAddress1 != nil
                && lAddress2 == rAddress2 && lAddress2 != nil && rAddress2 != nil)
    }
    
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
