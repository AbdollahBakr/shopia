//
//  GraphQLHelper.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation

// Encodable object to [String: Any]
extension Encodable {

    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
}
