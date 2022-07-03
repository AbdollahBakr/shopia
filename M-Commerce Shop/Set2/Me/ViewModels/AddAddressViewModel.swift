//
//  AddAddressViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation
import GraphQLite

class AddAddresseViewModel {
    
    var addresses = [Address]()
 
    func getAddresses() {
        
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
        
        GraphQLManager.fetchCodableFromQuery(genericType: DataClass.self, query: query, callBack: {[weak self] (response) in
            self?.addresses = (response?.customer?.addresses)!
        })
    }
    
    func addAddress(address: Address){
        
        // Get current API addresses, assign to addresses
        getAddresses()
        
        // Append newly created address
        addresses.append(address)

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
        
        // Empty addresses
        GraphQLManager.mutateWithQuery(query: Query(body: body, variables: variablesEmptyAddresses))
        // Wait until its empty
        Thread.sleep(forTimeInterval: 1)
        // Fill addresses
        GraphQLManager.mutateWithQuery(query: query)
    }
    
}
