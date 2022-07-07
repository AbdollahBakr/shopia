//
//  OrdersViewModel.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 07/07/2022.
//

import Foundation

class OrdersViewModel {
    
        // To Connect View With ViewModel Using Closures For Network Call
        var bindOrdersToHomeView    : (() -> ()) = {}
        
        // To Connect View With ViewModel Using Closures For Connection
        
        //Any Changes/action Happends In sportsArray call The Closure
         var ordersArray : [OrdersLineItem]?
        {
            didSet{
                // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
                bindOrdersToHomeView()
            }
        }
        
        func listOrders(variant_id:String) {
            
            NetworkManager.shared.getCustomerOrders(variant_id: variant_id, completion: { (orders, error) in
                if error == nil {
                    
                    self.ordersArray = orders
                    ArraysManager.orders = orders ?? []
                } else {
                    guard let err = error else {return}
                    print(err)
                }
            })
        }
}
