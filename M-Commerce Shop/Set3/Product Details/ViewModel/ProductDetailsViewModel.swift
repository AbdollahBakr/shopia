//
//  ProductDetailsViewModel.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 02.07.22.
//

import Foundation

class ProductDetailsViewModel{
    
    var networkservice: NetworkManager


    init (networkservice: NetworkManager){
        self.networkservice = networkservice
    }
    
    func getProduct (productID : Int, completion : @escaping (ProductDetail) -> Void ) {
        networkservice.getProductDetails(productID: productID) { productDetail, error in
            print("viewmodel \(productDetail)")
            guard let productDetail = productDetail else {
                return
            }
            completion(productDetail)
        }
    }
   
    
    
}
