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
        
        static var accessToken       = Int()
        static var refreshToken      = Int()
        
    }
    
    enum EndPoints {
        
        
        //Base URL
        static let base = "https://menofia-2022-q3.myshopify.com/admin/api/2022-04/"
    
    
        // Paths Cases
        case authSignup
        case productDetails
        
        /******* Change These Pathes With Our Needs ******/
        //ex:Auth,order....etc
        var stringValue: String {
            
            switch self {
                
            case .authSignup:
                return EndPoints.base + "/customers.json"
                
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
    func taskForGETRequest<ResponseType:Decodable>(url:URL, param: [String : Any]? = nil ,responseType: ResponseType.Type,completion: @escaping (ResponseType?, Error?) -> Void ){
        
        
//        var request = URLRequest(url: url)
//        request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
//      //  request.httpMethod = "GET"
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                print("Error: error calling GET")
//                print(error!)
//                return
//            }
//            guard let data = data else {
//                print("Error: Did not receive data")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
//            do {
//                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                    print("Error: Cannot convert data to JSON object")
//                    return
//                }
//                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                    print("Error: Cannot convert JSON object to Pretty JSON data")
//                    return
//                }
//                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                    print("Error: Could print JSON in String")
//                    return
//                }
//
//                print(prettyPrintedJson)
//            } catch {
//                print("Error: Trying to convert JSON data to string")
//                return
//            }
//        }.resume()

        
        var urlRequest : URLRequest?
        do {
            urlRequest = try URLRequest(url: url)
            urlRequest?.httpMethod = "GET"
            
        } catch {
            DispatchQueue.main.async {
                completion(nil, error)
            }
            }
        guard var urlRequest = urlRequest else {
            return
        }
        urlRequest.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")


        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in

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
    
    //    func fetchData<T:Codable, E: Codable>(url:String,parameters:Parameters?,headers:HTTPHeaders?,method:HTTPMethod?,completion: @escaping (T?,E? ,Error?)-> Void) {
    //
    //            Alamofire.request(url, method: method ?? .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
    //                .validate(statusCode: 200..<300)
    //                .responseJSON { (response) in
    //                switch response.result {
    //
    //                case .success(_):
    //
    //                    do {
    //                        guard let data = response.data else {return}
    //                        let responseData = try JSONDecoder().decode(T?.self, from: data)
    //                        completion(responseData, nil,nil)
    //                    } catch let jsonError {
    //                        print(jsonError)
    //                    }
    //                case .failure(let error):
    //                    let statusCode = response.response?.statusCode ?? 0
    //                    if statusCode > 300 {
    //
    //                    do {
    //                        guard let data = response.data else {return}
    //                        let responseError = try JSONDecoder().decode(E?.self, from: data)
    //                        completion(nil, responseError,nil)
    //                    } catch let jsonError {
    //                        print(jsonError)
    //                    }
    //                } else {
    //                    completion(nil,nil,error)
    //                }
    //            }
    //        }
    //
    //    }
    
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
//    func fbLogin(completion: @escaping(Bool, Error?)  -> Void) {
//
//        let body = CoreDataModel(strLeague: "s", strBadge: "ss", strYoutube: "ss", idLeague: "ss")
//
//        taskForPOSTRequest(url: EndPoints.authSignup.url, responseType: Leagues.self, body: body) { (response, error) in
//
//            if let response = response {
//
//                Auth.accessToken = response.id
//                Auth.refreshToken = response.id
//
//                completion(true, nil)
//                print(response)
//            } else {
//                completion(false, error)
//            }
//        }
//    }
    
}
    

