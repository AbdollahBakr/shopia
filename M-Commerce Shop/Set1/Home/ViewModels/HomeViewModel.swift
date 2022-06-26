//
//  HomeViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 24/06/2022.
//

import Foundation

class HomeViewModel {
    
    func potAllData() {
        
        NetworkManager.shared.fbLogin { (success, error) in
            if error == nil {
                //success
                print(success)
            }else {
                
                //err
                guard let err = error else {
                    return
                }
                
                print(err)
            }
        }
    }
}
