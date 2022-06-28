//
//  SignupUserData.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 26.06.22.
//

import Foundation

struct SignupUserData : Codable {
    var customer : CustomerModel
    
}


struct CustomerModel : Codable{
    var email                   : String
    var first_name              : String
    var last_name               : String
    var multipass_identifier    : String
    var send_email_invite       : Bool
}
