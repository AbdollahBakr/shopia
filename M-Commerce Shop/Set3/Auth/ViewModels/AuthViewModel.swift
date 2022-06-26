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
    
    func createUser (signupUserData: SignupUserData) {
      let url = NetworkManager.EndPoints.authSignup.url
        
        let cutomer = Customer(email: "Mempbob.example.com", first_name: "Memp", last_name: "Memp", multipass_identifier: "Memp", send_email_invite: true)
        let signupAccount = SignupUserData(customer: cutomer)
        networkservice.taskForPOSTRequest(url: url, responseType: CurrentAccount.self, body: signupAccount) { currentAccount, error in
            print(currentAccount)
            if currentAccount != nil {
                print(currentAccount!)
            }
        }
        
    }
}
