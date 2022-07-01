//
//  GraphQLManager.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 30/06/2022.
//

import Foundation
import GraphQLite

class GraphQLManager {
    
    // To store data in local sqlite if needed
    let db = GQLDatabase()
    
    // Shopify API data
    static let shopifyLink = "https://menofia-2022-q3.myshopify.com/admin/api/2022-04/graphql.json"
    static let headers = ["X-Shopify-Access-Token": "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"]
    
    // Fetch codable generic entity from the API
    static func fetchCodableFromQuery<T: Codable>(genericType: T.Type,
                                 query: Query,
                                 callBack: @escaping (T?) -> Void) {
        
        let server = GQLServer(HTTP: shopifyLink, headers: headers)

        server.query(query.body, query.variables ?? [:]) { result, error in
            if (error == nil) {
                var jsonData = Data()
                do {
                    // Serialize the result
                    jsonData = try JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed)
                    // Decode jsonData
                    let decodedResult = try JSONDecoder().decode(T.self, from: jsonData)
                    // Callback with the decoded result
                    callBack(decodedResult)
                } catch let error {
                    // Print Error and return nil in case of an exception
                    print(error)
                    callBack(nil)
                }
            }
        }
    }
    
    static func mutateWithQuery(query: Query) {
        let server = GQLServer(HTTP: shopifyLink, headers: headers)
        server.mutation(query.body, query.variables ?? [:]) { result, error in
          if (error == nil) {
            print("API Mutated Successfully")
          }
        }
    }
    
}
