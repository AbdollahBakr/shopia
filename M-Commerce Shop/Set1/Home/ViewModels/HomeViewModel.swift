//
//  HomeViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 24/06/2022.
//

import Foundation

class HomeViewModel {
<<<<<<< HEAD
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
=======

    
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
>>>>>>> de547e8dd6035f7dc71b03648cd88d065e62fc62
                
            } else {
                guard let err = error else {return}
                print(err)
            }
        }
    }
}
