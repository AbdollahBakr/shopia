//
//  WishlistViewModel.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 02.07.22.
//

import Foundation

class WishlistViewModel {
    

    var localDataSource: CoreDataManager
    
    init (localDataSource: CoreDataManager){
        self.localDataSource = localDataSource
    }
    
    
    func getfavProducts ()-> [ProductSavedModel]{
        return localDataSource.getWishlistProducts()
    }
    
    
}
