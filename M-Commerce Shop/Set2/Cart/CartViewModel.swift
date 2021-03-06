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
    
    var lineItems = [LineItem]()
    
    
    // TODO: Replace id with logged-in user id
    let query = Query(body: """
query getLineItemsInDraftOrder($id: ID!){
  draftOrder(id: $id) {
    currencyCode
    totalPrice
    subtotalPrice
    totalTax
    totalShippingPrice
    appliedDiscount {
              title
              value
              valueType
          }
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
                      , variables: ["id": Cart.draftOrderTempId])
    
    
    func getCartItems() {
        GraphQLManager.fetchCodableFromQuery(genericType: DataClass.self, query: query, callBack: {[weak self] (response) in
            self?.draftOrder = response?.draftOrder
        })
    }
    
    
    // Update Cart Items in API before proceeding to checkout
    func updateCartItems(cartItems: [Edge]) {

//        var lineItems = [LineItem]()
        let lineItems = Cart.sharedCart.cartItems
        // Last updated cart items
//        for item in cartItems {
//            lineItems.append(LineItem(quantity: item.node?.quantity, variantId: item.node?.variant?.id))
//        }
        
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
        let variables = AddLineItem(
            id: Cart.draftOrderTempId,
            input: Input(
                lineItems: lineItems)).dict!
        
        let query = Query(body: body, variables: variables)
        GraphQLManager.mutateWithQuery(query: query)
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
        
        
        let selectedCurrency = SettingsViewModel.settingsCells[1].settingValue
        var formattedPrice: String
        var calculatedValue = String()
        
        guard let value = value else {
            return ""
        }

        switch selectedCurrency {
        case "USD":
            if let floatValue = Float(value) {
                calculatedValue = (round(100*(floatValue / 18.81))/100).description
            }
            
        default:
            calculatedValue = value
        }
        
        formattedPrice = [calculatedValue, selectedCurrency]
            .compactMap { $0 }
            .joined(separator: " ")
        
        return formattedPrice
    }
}
