//
//  CartViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation

class CartViewModel {
    
    // Declare the binding closure
    var bindCartItemstoVC: (() -> ()) = {}
    
    var draftOrder: DraftOrder? {
        didSet {
            // Bind data everytime cart items reloads/changes
            bindCartItemstoVC()
        }
    }
    
    // TODO: Replace id with logged-in user id
    let query = Query(body: """
query getLineItemsInDraftOrder($id: ID!){
  draftOrder(id: $id) {
    currencyCode
    totalPrice
    totalTax
    totalShippingPrice
    lineItems(first: 20){
      edges {
        node {
          name
          quantity
          originalUnitPrice
          discountedUnitPrice
            variant {
                id
            }
          appliedDiscount {
              value
              valueType
          }
          image{
              url
          }
        }
      }
    }
  }
}
"""
, variables: ["id": "gid://shopify/DraftOrder/888534040747"])
    
    
    func getCartItems() {
        GraphQLManager.fetchCodableFromQuery(genericType: DataClass.self, query: query, callBack: {[weak self] (response) in
            self?.draftOrder = response?.draftOrder
        })
    }
    
    func deleteCartItem() {
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
    
    func formatPrice(value: String?) -> String {
        return [value, SettingsViewModel.settingsCells[1].settingValue]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}
