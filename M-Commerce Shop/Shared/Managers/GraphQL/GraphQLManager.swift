//
//  GraphQLManager.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 30/06/2022.
//

import Foundation
import GraphQLite

class GraphQLManager {
    
    let db = GQLDatabase()
    
    static func initManager() -> [String: Any] {
        let shopifyLink = "https://menofia-2022-q3.myshopify.com/admin/api/2022-04/graphql.json"
        let headers = ["X-Shopify-Access-Token": "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"]
        let server = GQLServer(HTTP: shopifyLink, headers: headers)
        
        let query1 = Query(body: """
{
  customers(first: 50) {
      edges {
      node {
        id
        firstName
        lastName
      }
    }
  }
}
""")
        _ = Query(body: "", variables: ["":""])

        var queryResponse = [String: Any]()
        server.query(query1.body, query1.variables ?? [:]) { result, error in
            if (error == nil) {
                queryResponse = result
                print(queryResponse)
            }
        }
        
        return queryResponse
    }
}
