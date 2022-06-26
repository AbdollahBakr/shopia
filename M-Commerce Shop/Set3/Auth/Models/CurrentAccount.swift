//
//  CurrentAccount.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 26.06.22.
//

import Foundation

struct CurrentAccount : Codable{
    
    var customer : CustomerResponse

}

struct CustomerResponse : Codable{
    var id                      : Int?
    var email                   : String?
    var first_name              : String?
    var last_name               : String?
//    var orders_count            : Int?
//    var total_spent             : String?
    var multipass_identifier    : String?
}
