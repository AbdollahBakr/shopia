//
//  AuthViewModel.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 26.06.22.
//

import Foundation

class AuthViewModel {
    
    var networkservice: NetworkManager
    
    
    init (networkservice: NetworkManager){
        self.networkservice = networkservice
    }
    
    func createUser (customer: CustomerModel, completionHnadler: @escaping ([String:Any]? , SignupError?) -> Void) {
        networkservice.signupUser(first_name: customer.first_name, last_name: customer.last_name, email: customer.email, password: customer.multipass_identifier) { (json, signupError)  in
            print(json as Any)
            completionHnadler(json, signupError)
        }
    }
    
    
    func loginUser(currentCustomer: Customer, completionHandler: @escaping (Customer?) -> Void){
        networkservice.getUser { customers, error in
            guard let customers = customers else {
                return
            }
            var customerExisted : Customer?
            customers.forEach({ customer in
                if currentCustomer.email == customer.email && currentCustomer.multipass_identifier == customer.multipass_identifier{
                    customerExisted = customer
                    return
                }
            })
            guard let customerExisted = customerExisted else {
                completionHandler(nil)
                return
            }
            completionHandler(customerExisted)
        }
    }
}
