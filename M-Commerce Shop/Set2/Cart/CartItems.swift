//
//  CartItems.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - DraftOrder
struct DraftOrder: Codable {
    let lineItems: LineItems?
    let currencyCode, totalPrice, totalTax, totalShippingPrice: String?
}

// MARK: - LineItems
struct LineItems: Codable {
    let edges: [Edge]?
}

// MARK: - Edge
struct Edge: Codable, Equatable {
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        let leftId = lhs.node?.variant?.id
        let rightId = rhs.node?.variant?.id
        
        return (leftId == rightId && leftId != nil && rightId != nil)
    }
    
    let node: Node?
}

// MARK: - Variant
struct Variant: Codable {
    let id: String?
}

// MARK: - Node
struct Node: Codable {
    let name, originalUnitPrice, discountedUnitPrice: String?
    let variant: Variant?
    let quantity: Int?
    let appliedDiscount: JSONNull?
    let image: Image?
}

// MARK: - Image
struct Image: Codable {
    let url: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
