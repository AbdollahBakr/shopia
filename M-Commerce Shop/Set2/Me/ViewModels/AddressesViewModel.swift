//
//  AddressesViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation

class AddressesViewModel {
    // Declare the binding closure
    var bindAddressestoVC: (() -> ()) = {}
    
    var addresses: [Address]? {
        didSet {
            // Bind data everytime sports reloads/changes
            bindAddressestoVC()
        }
    }
    
    // TODO: Replace id with logged-in user id
    let query = Query(body: """
query getMeAsACustomer($id: ID!) {
customer(id: $id) {
addresses {
    country
    city
    address1
}
}
}
"""
, variables: ["id": "gid://shopify/Customer/6059105484971"])
    
    
    func getAddresses() {
        GraphQLManager.fetchCodableFromQuery(genericType: DataClass.self, query: query, callBack: {[weak self] (response) in
            self?.addresses = response?.customer?.addresses
        })
    }
    
}
