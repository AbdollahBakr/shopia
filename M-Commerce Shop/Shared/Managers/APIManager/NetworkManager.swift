//
//  NetworkManager.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 24/06/2022.
//

import UIKit
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()

     private init() {
        
    }
    
    //Any Needed Data For Authentication
    struct Auth {
        
        static var accessToken       = ""
        static var appleAcccessToken = ""
        static var refreshToken      = ""
       
        static var expired           = Date()
        static let clientID          = "v4nB5Ne1YmKYl0LRZ1uj8Z6XEKsaCNrvFpkTRyLN"
       
        static let clientSecret      = "4nrs24A27XejXcuH5jrBKFwg1d9PhcaGkPnWj4Uy7YpWVZ5EnIGrqh6OJOYG28svx93D9wS29QdxmGW3HS1N5MdSbHOuMuS6Q8qWI3VpQWvUUrCI8x8ECytr2FP4jG2G"
        
        static let userTypeCustomer  = "customer"
        static let userTypeDriver    = "driver"
    }
     
    enum EndPoints {
        
        //Base URL
        static let base = "https://menofia-2022-q3.myshopify.com"
        
    
        // Paths Cases
        case sportsList
        
        case leaguesList
        
        case leageDetails
        
        case leageTeams
        
        /******* Change These Pathes With Our Needs ******/
        //ex:Auth,order....etc
        var stringValue: String {
            
            switch self {
            
            case .sportsList:
                return EndPoints.base + "/api/v1/json/2/all_sports.php"
                
            case .leaguesList:
                return EndPoints.base + "/api/v1/json/2/search_all_leagues.php?s="
                
            case .leageDetails:
                return EndPoints.base + "/api/v1/json/2/eventsseason.php?"
                
            case .leageTeams:
                return EndPoints.base + "/api/v1/json/2/search_all_teams.php?"
          
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
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void){
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
    
//    func getAllSports(completion: @escaping ([SportResults], Error?) -> Void) {
//
//        let endPoints = EndPoints.sportsList.url
//
//        //responseType -> the main model
//        taskForGETRequest(url:endPoints , responseType: SportsData.self) { (response, error) in
//            if let response = response  {
//                //result -> is the [meals]
//                completion(response.sports,nil)
//            } else {
//                completion([],error)
//            }
//        }
//    }
    
    
    
    /***** Example USING POST Request.... ***/
    
//    func fbLogin(userType: String, completion: @escaping (Bool, Error?)  -> Void) {
//
//        let body = LoginConvertToken(grant_type: "convert_token", backend: "facebook", user_type: userType, client_id: Auth.clientID, client_secret: Auth.clientSecret,token: AccessToken.current!.tokenString)
//        taskForPOSTRequest(url: EndPoints.socialAuthLogin.url, responseType: LoginConvertTokenResponse.self, body: body) { (response, error) in
//            if let response = response {
//                Auth.accessToken = response.access_token
//                Auth.refreshToken = response.refresh_token
//                Auth.expired = Date().addingTimeInterval(TimeInterval(response.expires_in))
//                completion(true, nil)
//                print(response)
//            } else {
//                completion(false, .invalidResponse)
//            }
//        }
//    }
    

    
}
