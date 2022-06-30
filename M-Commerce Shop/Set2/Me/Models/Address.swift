//
//  Address.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import Foundation
import GraphQLite

class Address: NSObject, GQLObject {
   
    @objc var addressId = ""
    @objc var country = ""
    @objc var city = ""
    @objc var address1 = ""
    @objc var address2 = ""
    
    static func primaryKey() -> String {
        return "addressId"
    }
    
//    init() {
//        self.country = ""
//        self.city = ""
//        self.address1 = ""
//        self.address2 = ""
//    }
//
//    init(country: String?, city: String?, address1: String?, address2: String?) {
//        self.country = country
//        self.city = city
//        self.address1 = address1
//        self.address2 = address2
//    }
}
