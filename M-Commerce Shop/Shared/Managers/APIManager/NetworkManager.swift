//
//  NetworkManager.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 24/06/2022.
//

import UIKit
import Foundation



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
        
        
        /******* Change These Pathes With Our Needs ******/
        //ex:Auth,order....etc
        var stringValue: String {
            
            switch self {
            
            case .authSignup:
                return EndPoints.base + "/customers.json"
                
          
            }
        }
        
        // To Convert Them Into URL
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
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
       // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")

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

    
    //Example USING GET Request....
//    func getAllSports(completion: @escaping ([Leagues]?, Error?) -> Void) {
//
//        let endPoints = EndPoints.authLogin.url
//
//        //responseType -> the main model
//        taskForGETRequest(url:endPoints , responseType: CoreDataModel.self) { (response, error) in
//            if let response = response  {
//                //result -> is the [meals]
//                completion(response.strLeague,nil)
//            } else {
//                completion([],error)
//            }
//        }
//    }
    
    
    
    /***** Example USING POST Request.... ***/
    //Note: It's Just An Example Don't Use This Post Request In Any View
     func fbLogin(completion: @escaping(Bool, Error?)  -> Void) {

        let body = CoreDataModel(strLeague: "s", strBadge: "ss", strYoutube: "ss", idLeague: "ss")

        taskForPOSTRequest(url: EndPoints.authSignup.url, responseType: Leagues.self, body: body) { (response, error) in

            if let response = response {

                Auth.accessToken = response.id
                Auth.refreshToken = response.id

                completion(true, nil)
                print(response)
            } else {
                completion(false, error)
            }
        }
    }
    

    
}
