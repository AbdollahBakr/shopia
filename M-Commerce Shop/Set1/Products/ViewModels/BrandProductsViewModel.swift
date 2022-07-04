//
//  BrandsProductsViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 03/07/2022.
//

import Foundation

class BrandProductsViewModel {
    // To Connect View With ViewModel Using Closures For Network Call
    var bindBrandProductsToProductsView    : (() -> ()) = {}
    
    // To Connect View With ViewModel Using Closures For Connection
    
    //Any Changes/action Happends In sportsArray call The Closure
    var brandProductsArray : [ProductsResult]?
    {
        didSet{
            // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
            bindBrandProductsToProductsView()
        }
    }
    
    func listBrands(brandId:Int) {
        
        NetworkManager.shared.getBrandProducts(brandId: brandId) { [weak self] (brandProducts, error) in
            if error == nil {
                
                self?.brandProductsArray = brandProducts
                
            } else {
                guard let err = error else {return}
                print(err)
            }
        }
    }
}
