//
//  CategoriesViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 04/07/2022.
//

import Foundation
class CategoryViewModel {
    // To Connect View With ViewModel Using Closures For Network Call
    var bindCategoriesToProductsView    : (() -> ()) = {}
    
    // To Connect View With ViewModel Using Closures For Connection
    
    //Any Changes/action Happends In sportsArray call The Closure
    var categoriesArray : [Custom_collections]?
    {
        didSet{
            // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
            bindCategoriesToProductsView()
        }
    }
    
    func listCategories() {
        
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
