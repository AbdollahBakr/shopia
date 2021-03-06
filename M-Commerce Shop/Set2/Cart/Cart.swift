//
//  Cart.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation


// MARK: - Cart Model
class Cart {
    
    // Singleton Design Pattern
    static let sharedCart = Cart()
    
    // draft order id for GraphQL
    var draftOrderId: String? {
        didSet {
            // For testing
            print("draftOrderId didSet: \(draftOrderId)")
            Cart.draftOrderTempId = draftOrderId ?? ""
        }
    }
    
    // Placeholder draftOrder id for testing
    static var draftOrderTempId = "gid://shopify/DraftOrder/888534040747"
//    static var draftOrderTempId = "gid://shopify/DraftOrder/888541642923"
    
    // Holds cart items
    var cartItems = [LineItem]()
    
    // GraphQL Query
    var customerId: String?
    
    private init() {
//        draftOrderId = initDraftOrder(customerId: customerId, variantId: variantId)
    }
    
 
    
    
    // Adds an item with the unique variantId to cartItems
    func addToCart(variantId: String) {
        
        // If a user is logged-in
        if Helper.isUserLoggedIn() {
            
            // Create a draft order if not exist
            if draftOrderId == nil {
//                initDraftOrder(customerId: customerId ?? "", variantId: variantId)
                draftOrderId = Cart.draftOrderTempId
                print("draftOrderId: \(draftOrderId)")
            }
            
            // Check if item already added
            for item in cartItems {
                if item.variantId == variantId {
                    Helper.displayMessage(message: "Item already added", messageError: true)
                    return
                }
            }
            
            // Add variant item to cart
            let lineItem = LineItem(quantity: 1, variantId: variantId)
            cartItems.append(lineItem)
            
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
                id: draftOrderId ?? "",
                input: Input(
                    lineItems: cartItems)).dict!
            
            let query = Query(body: body, variables: variables)
            GraphQLManager.mutateWithQuery(query: query)
            
            // Notify added to cart
            Helper.displayMessage(message: "Added to cart", messageError: false)
            
        } else {
            Helper.displayMessage(message: "Sign in to add to cart", messageError: true)
        }
        
    }
    
    // Initialize draft Order if not exist
    func initDraftOrder(customerId: String, variantId: String) {
        // Setup Query
        let body = """
            mutation draftOrderCreate($input: DraftOrderInput!) {
                draftOrderCreate(input: $input) {
                    draftOrder {
                        id
                    }
                    userErrors {
                        message
                        field
                    }
                }
            }
        """
        
        let variables = CreateInput(customerId: customerId, lineItems: cartItems).dict!
        
        let query = Query(body: body, variables: variables)
        
        
        // Create draft order
        GraphQLManager.fetchCodableFromQuery(genericType: DraftCreateResponse.self, query: query, callBack: {[weak self] (response) in
            self?.draftOrderId = response?.draftOrderCreate.draftOrder.id
        })
//        GraphQLManager.mutateWithQuery(query: query)

        // Plug-in created draftOrderId from response
//        return draftOrderId
    }
}

// MARK: CODABLE ENTITIES FOR GRAPHQL QUERIES

// MARK: - Add Line Item GraphQL input
struct AddLineItem: Codable {
    let id: String
    let input: Input
}

struct Input: Codable {
    let lineItems: [LineItem]
}

// Use aliasing if necessary (CreateInput to Input)
struct CreateInput: Codable {
    let customerId: String
    let lineItems: [LineItem]
}
// MARK: - LineItem
struct LineItem: Codable {
    let quantity: Int?
    let variantId: String?
}

// MARK: - AppliedDiscount
struct AppliedDiscount: Codable {
    let appliedDiscountDescription: String?
    let value: Float?
    let amount: Double?
    let valueType, title: String?

    enum CodingKeys: String, CodingKey {
        case appliedDiscountDescription = "description"
        case value, amount, valueType, title
    }
}

// MARK: - Weight
struct Weight: Codable {
    let value: Int?
    let unit: String?
}

// MARK: - ShippingLine
struct ShippingLine: Codable {
    let title: String?
    let price: Double?
}


// MARK: - Cart Item
struct CartItem: Codable {
    let variantId: String
    let quantity: Int
}


// MARK: - Draft Order Create Response
struct DraftCreateResponse: Codable {
    let draftOrderCreate: DraftOrderCreate
}

// MARK: - DraftOrderCreate
struct DraftOrderCreate: Codable {
    let draftOrder: DraftOrder
}
