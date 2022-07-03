//
//  ProductDetailsViewModel.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 02.07.22.
//

import Foundation
import UIKit
import CoreData

class ProductDetailsViewModel{
    
    var networkservice: NetworkManager
    var localDataSource: CoreDataManager

    init (networkservice: NetworkManager){
        self.networkservice = networkservice
        self.localDataSource = CoreDataManager.shared
    }
    
    func getProduct (productID : Int, completion : @escaping (ProductDetail) -> Void ) {
        networkservice.getProductDetails(productID: productID) { productDetail, error in
//            print("viewmodel \(productDetail)")
            guard let productDetail = productDetail else {
                return
            }
            completion(productDetail)
        }
    }
   
    func saveProduct(viewContext: NSManagedObjectContext, favProduct: ProductDetail){
        guard let favProduct = favProduct.product else {
            return
        }
        let productSavedModel =  ProductSavedModel(id: String(favProduct.id ?? 0), title: favProduct.title, price: favProduct.variants?.first?.price, image: favProduct.image?.src)
        
     var result = localDataSource.save(viewContext: viewContext, productDetail: productSavedModel)
        
    }
    
    func deleteProduct(favProduct: ProductDetail){
        guard let productID = favProduct.product?.id else {
            return
        }
        localDataSource.delete(productID: String(productID))
    }
    
    func isFavoritProduct(productID : Int )-> Bool{
        localDataSource.isFavoriteProduct(productID: String(productID))
    }
    
}

struct ProductSavedModel{
    let id : String?
    let title : String?
    let price : String?
    let image : String?
}


