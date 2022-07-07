//
//  CustomerOrders.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 07/07/2022.
//

import Foundation

struct CustomerOrdersResult:Codable {
    
    let created_at         :String?
    let line_items         :[OrdersLineItem]?
    
}
