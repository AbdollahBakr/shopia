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
    var id                      : Int?
    var email                   : String?
    var first_name              : String?
    var last_name               : String?
//    var orders_count            : Int?
//    var total_spent             : String?
    var multipass_identifier    : String?
}
