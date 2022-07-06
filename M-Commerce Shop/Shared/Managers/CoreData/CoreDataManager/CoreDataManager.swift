//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Macbook on 15/06/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static var shared  = CoreDataManager()
    
    //Entity Name in Core Data
    var entityName     : String?
    
    // To Access viewContext from NSManagedObjectContext and saveContext() in AppDelegate
    var appDelegate    : AppDelegate?
    
    // NSManagedObjectContext => Responsible for managing objects in data base to create managed objects using instances (ex:from Movie)  by getting copies from this database
     // This Gives Us Object From DataBase To Store Our Data There
    let  viewContext   : NSManagedObjectContext?
    
    // For Detecting The Current Movie
    var currentLeague: NSManagedObject?
    
    private init() {
       
        entityName  = "Favourite_Product"
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        viewContext = appDelegate?.persistentContainer.viewContext
        
    }
    
    func fetchLeaguesData() -> [CoreDataModel] {
        
        ArraysManager.coreDataArray.removeAll()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataManager.shared.entityName!)
        
        do {
            let leagues = try viewContext!.fetch(fetchRequest)
           
            for league in leagues {
                
                ArraysManager.coreDataArray.append(CoreDataModel.init(strLeague: league.value(forKey: "strLeague") as? String ?? "", strBadge: league.value(forKey: "strBadge") as? String ?? "", strYoutube: league.value(forKey: "strYoutube") as? String ?? "", idLeague: league.value(forKey: "idLeague") as? String ?? ""))
            }
            
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        return ArraysManager.coreDataArray
    }
    
    func save(viewContext:NSManagedObjectContext ,productDetail: ProductSavedModel) -> Bool {
        
        let isExistedBefore = isFavoriteProduct(productID: productDetail.id ?? "")
        if !isExistedBefore {
            guard
                let productName = productDetail.title,
                !productName.isEmpty,
                let productImage = productDetail.image,
                !productImage.isEmpty,
                let productPrice = productDetail.price,
                !productPrice.isEmpty,
                let productID = productDetail.id,
                !productID.isEmpty
            else {
                print("Missing Data")
                return false
            }
            
            // Two Steps For Getting Entity (Table) From our object => viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: CoreDataManager.shared.entityName!, in: viewContext) else {
                return false
            }
            
            // Get The Class Required For Performing behavior required of a Core Data model object.
            let favoriteEntity = NSManagedObject(entity: entity,
                                                 insertInto: viewContext)
            
            // Set Properties Inserted Data From User To Movies Table (Entity)
            favoriteEntity.setValue(productName, forKey: "title")
            favoriteEntity.setValue(productImage, forKey: "image")
            favoriteEntity.setValue(productPrice, forKey: "price")
            favoriteEntity.setValue(productID, forKey: "id")
            
            // Save Our Data (Properties) Into CoreData
            print("Product saved successfully!")
            appDelegate?.saveContext()
            
            return true
        }else{
            return false
        }
        
    }
    
    func isFavoriteProduct (productID: String) -> Bool{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName ?? "Favourite_Product")
        
        var predicateProduct = NSPredicate(format: "id == %@", productID as! CVarArg)
        fetchRequest.predicate = predicateProduct
        
        do{
            let productNSManagedObjects = try viewContext?.fetch(fetchRequest)
            if (productNSManagedObjects?.first ?? nil) == nil{
                return false
            }
            return true
        }catch let error as NSError {
            print(error)
        }
        return true
    }
    
    func deleteMovie(index: Int) {
  
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName!)
        
        do {
            let leagues = try viewContext?.fetch(fetchRequest)
            
            self.currentLeague = leagues?[index]
            
            viewContext?.delete(currentLeague!)
            
            appDelegate?.saveContext()
            
            print("deleted")
            
        }  catch let error {
            print(error.localizedDescription)
        }
        
        
    }
    
    func delete(productID: String) {
        guard let viewContext = viewContext
        else {return}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName ?? "Favourite_Product")
        
        let predicateProduct = NSPredicate(format: "id == %@", productID as! CVarArg)
        fetchRequest.predicate = predicateProduct
        
        do{
            let productNSManagedObjects = try viewContext.fetch(fetchRequest)
            if (productNSManagedObjects.first ?? nil) != nil{
                viewContext.delete(productNSManagedObjects.first!)
                appDelegate?.saveContext()
            }
        }catch let error as NSError {
            print(error)
        }
      
    }
    
    func getWishlistProducts () ->[ProductSavedModel] {
        guard let viewContext = viewContext else {return [ProductSavedModel]()}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName ?? "Favourite_Product")
        do{
            let productEntities = try viewContext.fetch(fetchRequest)
            
            var productObjects = [ProductSavedModel]()
            
            productEntities.forEach { productEntity in
                
                let currentProduct = ProductSavedModel(id: productEntity.value(forKey: "id") as? String, title: productEntity.value(forKey: "title") as? String, price: productEntity.value(forKey: "price") as? String, image: productEntity.value(forKey: "image") as? String)
                
                productObjects.append(currentProduct)
            }
            return productObjects
        } catch let error {
            print(error.localizedDescription)
        }
        return [ProductSavedModel]()
    }
    
}

