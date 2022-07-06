//
//  NetworkManager.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 24/06/2022.
//

import UIKit
import Foundation
import Alamofire


class NetworkManager {
    
    
    // Singlton Logic
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    //Any Needed Data For Authentication
    
    struct Auth {
        
        static var accessToken       = ""
        static var refreshToken      = ""
        
    }
    
    enum EndPoints {
        
        
        //Base URL
        static let base = "https://fde429753a207f610321a557c2e0ceb0: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@menofia-2022-q3.myshopify.com/admin/api/2022-04"
    
    
        // Paths Cases
        case authSignup
        
        /******************** Home  **************** **/
        // Brands
        case getCategories
        case getBrands
        case getBrandProducts
        case productDetails
        

        /******* Change These Pathes With Our Needs ******/
        //ex:Auth,order....etc
        var stringValue: String {
            
            switch self {
                
            case .authSignup:
                return EndPoints.base + "/customers.json"
                

            case .getCategories:
                return EndPoints.base + "/smart_collections.json"
                

            case .getBrands:
                return EndPoints.base + "/smart_collections.json"

            case .getBrandProducts:
                return EndPoints.base + "/products.json?"
                
            case .productDetails:
                return EndPoints.base + "products/"
            }
        }
        
        
        
        // To Convert Them Into URL
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    let baseURL = NSURL(string: "https://menofia-2022-q3.myshopify.com/admin/api/2022-04")
    
    //Generic Get Request We Usually don't pass parameters like post we put it in the url
    func taskForGETRequest<ResponseType:Decodable>(url:URL, responseType: ResponseType.Type,completion: @escaping (ResponseType?, Error?) -> Void ){
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(nil,error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil,error)
                return
            }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void){
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Header
        request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let _ = error {
                completion(nil,error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil,error)
                return
            }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    
    
    // Request Server function  or user instead of JSON? -> [String: Any]
    func requestServer(_ method: HTTPMethod,_ path: String,_ params: [String: Any]?,_ encoding: ParameterEncoding,_ completionHandler: @escaping ([String:Any]?, SignupError?) -> Void ) {
        
        let url = baseURL!.appendingPathComponent(path)
        let headers = ["X-Shopify-Access-Token" : "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"]
        Alamofire.request(url!, method: method, parameters: params,headers: headers).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                let jsonData = (value) as? [String:Any]
                
                let decoder = JSONDecoder()
                do {
                    let signupErrorObject = try decoder.decode(SignupError.self, from: response.data!)
                    DispatchQueue.main.async {
                        completionHandler(nil, signupErrorObject)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(jsonData, nil)
                    }
                }
                break
                
            case .failure:
                completionHandler(nil, nil)
                break
            }
        }
    }
    
    func signupUser(first_name: String, last_name: String, email: String, password: String, completionHandler: @escaping ([String: Any]?, SignupError?) -> Void) {
        let path = "/customers.json"
        
        let params: [String: Any] = [
            "customer": [
                "first_name": first_name,
                "last_name" : last_name,
                "email" : email,
                "verified_email":true,
                "multipass_identifier" :password,
            ]
        ]
        requestServer(.post, path, params, URLEncoding(), completionHandler)
       
    }
    
    func getUser(completion: @escaping ([CustomerItem]?, Error?) -> Void){
        let url = EndPoints.authSignup.url
        
        taskForGETRequest(url: url, responseType: Customers.self) { (response, error) in
                        if let response = response  {
                            //result -> is the [meals]
                            completion(response.customers, nil)
                        } else {
                            completion(nil,error)
                        }
                    }
    }
    

    

    /***********  Home   ********/
    func getBrands(completion: @escaping ([SmartCollections]?, Error?) -> Void){
        let url = EndPoints.getBrands.url
        taskForGETRequest(url: url, responseType: BrandsBase.self) { (response, error) in
            if let response = response  {
                //result -> is the [meals]
                completion(response.smart_collections, nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    func getBrandProducts(brandId:Int,completion:@escaping([ProductsResult]?,Error?)->Void) {
        let endPoints = EndPoints.getBrandProducts.stringValue + "collection_id=\(brandId)"
     
        guard let url = URL(string: endPoints) else {
            return
        }
        
        taskForGETRequest(url: url, responseType: ProductsBase.self) { (response, error) in
            if let response = response  {
                //result -> is the [meals]
                completion(response.products, nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    /***********  Home   ********/
       func getCategories(completion: @escaping ([Custom_collections]?, Error?) -> Void){
           let url = EndPoints.getCategories.url
           taskForGETRequest(url: url, responseType: CategoriesBase.self) { (response, error) in
               if let response = response  {
                   completion(response.custom_collections, nil)
               } else {
                   completion(nil,error)
               }
           }
       }
      
       
       func getSubCategories(collection_id:Int,product_type:String,completion:@escaping([ProductsResult]?,Error?)->Void) {
           
           let endPoints = EndPoints.getCategories.stringValue + "collection_id=\(collection_id)" + "product_type=\(product_type)"
        
           guard let url = URL(string: endPoints) else {
               return
           }
           taskForGETRequest(url: url, responseType: ProductsBase.self) { (response, error) in
               if let response = response  {
                   completion(response.products, nil)
               } else {
                   completion(nil,error)
               }
           }
       }
    
    func getProductDetails (productID: Int , completionHandler: @escaping (ProductDetail?, Error?) -> Void){
        let endPoints = EndPoints.productDetails.stringValue + "\(productID).json"
        
        
        taskForGETRequest(url: URL(string: endPoints)!, responseType: ProductDetail.self) { (response , error) in
            if let response = response  {
                //result -> is the [meals]
                completionHandler(response ,nil)
            } else {
                completionHandler(nil ,error)
            }
        }
    }

    
    
  
}
    


