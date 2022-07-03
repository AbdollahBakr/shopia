//
//  HomeViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 24/06/2022.
//

import Foundation

class HomeViewModel {

    
    // To Connect View With ViewModel Using Closures For Network Call
    var bindBrandsToHomeView    : (() -> ()) = {}
    
    // To Connect View With ViewModel Using Closures For Connection
    
    //Any Changes/action Happends In sportsArray call The Closure
    var brandsArray : [SmartCollections]?
    {
        didSet{
            // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
            bindBrandsToHomeView()
        }
    }
    
    func listBrands() {
        
        NetworkManager.shared.getBrands { [weak self] (brands, error) in
            if error == nil {
                
                self?.brandsArray = brands
                
            } else {
                guard let err = error else {return}
                print(err)
            }
        }
    }
}
