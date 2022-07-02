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
            // Bind data everytime addresses reloads/changes
            bindAddressestoVC()
        }
    }
    
    // TODO: Replace id with logged-in user id
    let query = Query(body: """
query getCustomerAddresses($id: ID!) {
customer(id: $id) {
addresses {
    country
    city
    address1
    address2
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
    
    func deleteAddress() {
        let body = """
            mutation customerUpdate($input: CustomerInput!) {
            customerUpdate(input: $input) {
            userErrors {
                  field
                  message
                }
            }
            }
        """
        
        let variables = ["input": [
            "id": "gid://shopify/Customer/6059105484971",
            "addresses":[
                [
                    "address1": "",
                    "address2": "",
                    "city": "",
                    "country": ""
                ]
            ]
          ]]
        let query = Query(body: body
                          , variables: variables)
        
        GraphQLManager.mutateWithQuery(query: query)
    }
    
}
