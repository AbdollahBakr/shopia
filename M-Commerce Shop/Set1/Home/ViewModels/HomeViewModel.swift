//
//  HomeViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 24/06/2022.
//

import Foundation

class HomeViewModel {
    // To Connect View With ViewModel Using Closures For Network Call
    var bindCategoriesToHomeView    : (() -> ()) = {}
    
    //Any Changes/action Happends In sportsArray call The Closure
    var categoriesArray : [SmartCollections]?
    {
        didSet{
            // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
            bindCategoriesToHomeView()
        }
    }
    
    
    func listCategoriesData() {
        
        NetworkManager.shared.getCategories { [weak self] (categories, error) in
            if error == nil {
                
                self?.categoriesArray = categories
                
            } else {
                guard let err = error else {return}
                print(err)
            }
        }
    }
}
