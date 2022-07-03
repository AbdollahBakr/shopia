//
//  CurrentAccount.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 26.06.22.
//

import Foundation

struct Customers : Codable{
    
    var customers : [Customer]

}

struct Customer : Codable{
    var id                      : String?
    var email                   : String?
    var firstName              : String?
    var lastName               : String?
//    var orders_count            : Int?
//    var total_spent             : String?
    var multipass_identifier    : String?
    var numberOfOrders          : String?
    let addresses               : [Address]?
}
