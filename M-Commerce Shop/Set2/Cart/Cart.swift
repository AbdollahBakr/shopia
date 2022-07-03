//
//  Cart.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation


// MARK: - Add Line Item GraphQL input
struct AddLineItem: Codable {
    let id: String
    let input: Input
}

struct Input: Codable {
    let lineItems: [LineItem]
}

// MARK: - LineItem
struct LineItem: Codable {
    let quantity: Int?
    let variantId: String?
}
// MARK: - Input
//struct Input: Codable {
//    let draftOrderId, customerID, note, email: String?
//    let shippingLine: ShippingLine?
//    let appliedDiscount: AppliedDiscount?
//    let lineItems: [LineItem]?
//
//    enum CodingKeys: String, CodingKey {
//        case customerID = "customerId"
//        case draftOrderId = "id"
//        case note, email, shippingLine, appliedDiscount, lineItems
//    }
//}

// MARK: - AppliedDiscount
struct AppliedDiscount: Codable {
    let appliedDiscountDescription: String?
    let value: Float?
    let amount: Double?
    let valueType, title: String?

    enum CodingKeys: String, CodingKey {
        case appliedDiscountDescription = "description"
        case value, amount, valueType, title
    }
}

//// MARK: - LineItem
//struct LineItem: Codable {
//    let title: String?
//    let originalUnitPrice: Double?
//    let quantity: Int?
//    let appliedDiscount: AppliedDiscount?
//    let weight: Weight?
//    let variantID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case title, originalUnitPrice, quantity, appliedDiscount, weight
//        case variantID = "variantId"
//    }
//}

// MARK: - Weight
struct Weight: Codable {
    let value: Int?
    let unit: String?
}

// MARK: - ShippingLine
struct ShippingLine: Codable {
    let title: String?
    let price: Double?
}


// MARK: - Cart Item
struct CartItem: Codable {
    let variantId: String
    let quantity: Int
}