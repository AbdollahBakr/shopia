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
    
    func deleteAddress(addresses: [Address]) {

        // Query Setup
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
        
        let variablesEmptyAddresses = AddAddressModel(input: AddAddressInput(id: "gid://shopify/Customer/6059105484971", addresses: [Address]())).dict!
        
        let variables = AddAddressModel(input: AddAddressInput(id: "gid://shopify/Customer/6059105484971", addresses: addresses)).dict!
        
        let query = Query(body: body
                          , variables: variables)
  
        DispatchQueue.global().async {
            // Empty addresses
            GraphQLManager.mutateWithQuery(query: Query(body: body, variables: variablesEmptyAddresses))
        }
        
//        // Wait until its empty
//        print("sleep")
        Thread.sleep(forTimeInterval: 2)
//        print("wakeup")
        // Fill addresses
        GraphQLManager.mutateWithQuery(query: query)
    }
    
}
