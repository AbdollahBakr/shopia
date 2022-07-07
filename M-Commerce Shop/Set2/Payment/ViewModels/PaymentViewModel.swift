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
    
    func sendInvoice() {
        // Setup Query body and variables
        let body = """
            mutation draftOrderInvoiceSend($id: ID!, $email: EmailInput) {
              draftOrderInvoiceSend(id: $id, email: $email) {
                draftOrder {
                  id
                }
              }
            }
        """
        let variables = ["id": draftOrderId,
                         "template_name": "DRAFT_ORDER_INVOICE"
        ]
        
        let query = Query(body: body, variables: variables)
        GraphQLManager.mutateWithQuery(query: query)
    }
    
    func payOnline() {
        // Online payment logic
    }
}
