//
//  MeViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 02/07/2022.
//

import Foundation
import SwiftUI


class MeViewModel {
    
//    var userDefaults = UserDefaults()
    
//    let userIdInt = UserDefaults().integer(forKey: "userId")
    
//    let currentCustomerId = "gid://shopify/Customer/\(userIdInt)"
// "gid://shopify/Customer/6059105484971"
    var bindCustomertoVC: (() -> ()) = {}
    var currentCustomer: Customer? {
        didSet {
            bindCustomertoVC()
        }
    }
    
    let query = Query(body: """
    query getCustomer($id: ID!){
      customer(id: $id) {
          id
        firstName
        lastName
        numberOfOrders
        email
        addresses {
            country
            city
            address1
            address2
        }
      }
    }
""", variables: ["id": "gid://shopify/Customer/\(UserDefaults().integer(forKey: "userId"))"])
    
    
    func getCurrentCustomer() {
        GraphQLManager.fetchCodableFromQuery(genericType: DataClass.self, query: query, callBack: {[weak self] (response) in
            self?.currentCustomer = response?.customer
        })
    }
}
