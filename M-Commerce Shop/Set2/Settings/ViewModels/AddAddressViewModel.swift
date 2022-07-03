//
//  AddAddressViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation
import GraphQLite

class AddAddresseViewModel {
    
    var addresses: [Address]?
    
    // TODO: Replace id with logged-in user id
    func constructMutationQuery(address: Address) -> Query {
//        addresses?.append(address)
//        let encodedAddresses = addresses?.compactMap{$0.dict} as Any
        
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
                    "address1": address.address1,
                    "address2": address.address2,
                    "city": address.city,
                    "country": address.country
                ]
            ]
          ]]
        let query = Query(body: body
                          , variables: variables)
        
        return query
    }
    
    
    
//    func getAddresses() {
//        GraphQLManager.fetchCodableFromQuery(genericType: DataClass.self, query: query, callBack: {[weak self] (response) in
//            self?.addresses = response?.customer?.addresses
//        })
//    }
    
    func addAddress(address: Address){

        GraphQLManager.mutateWithQuery(query: constructMutationQuery(address: address))
    }
    
}
