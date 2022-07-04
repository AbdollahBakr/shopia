//
//  PaymentViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 03/07/2022.
//

import Foundation

class PaymentViewModel {
    
    var draftOrderId = Cart.draftOrderTempId
    
    func payCashOnDelivery() {
        
        // Setup Query body and variables
        let body = """
            mutation draftOrderUpdate($id: ID!, $input: DraftOrderInput!) {
                draftOrderUpdate(id: $id, input: $input) {
                    draftOrder {
                        id
                    }
                    userErrors {
                        field
                        message
                    }
                }
            }
        """
        let variables = ["id": draftOrderId]
        
        let query = Query(body: body, variables: variables)
        GraphQLManager.mutateWithQuery(query: query)
    }
    
    func payOnline() {
        // Online payment logic
    }
}
