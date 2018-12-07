//
//  UPCitemdbAPI.swift
//  App
//
//  Created by Mark Nickerson on 12/6/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
// API:
//     - APIerror struct, returned in completion when errors arise
//     - FoodProduct struct, returned in completion when api call is successful
//     - ApiCall function, returns APIerror or FoodProduct
//         - Contains alamofire URL request (secheduled to DispatchQueue.main)


import Foundation
import Alamofire

var UPCitemdbSessionManager = Alamofire.SessionManager.init(configuration: .default)

struct UPCitemdbAPI{
    
    struct APIerror: Codable {
        var code: String
        var message: String
        
        init(response: String){
            self.code = response
            self.message = response
        }
    }
    
    typealias APIcompletion = ((_ response: FoodProduct?, _ error: APIerror?) -> Void)
    typealias APIfunctionCompletion = ((_ response: [String:Bool], _ error: APIerror?) -> Void)
    
    struct FoodProduct: Codable {
        var code: String
        var total: Int
        var offset: Int
        var items: [Item]
        
        struct Item: Codable {
            //var ean: String
            var title: String
            var upc: String
            //var gtin: String
            //var asin: String
            var description: String
            var brand: String
            //var model: String
            //var dimension: String
            //var weight: String
            //var currency: String
            var images: [String]
        }
        
        func getLabel() -> String{
            // Process label for a better display experience
            var label = items[0].title.capitalized
            
            if label.contains(items[0].brand){
                label = label.replacingOccurrences(of: items[0].brand, with: "")
            }
            
            if label.hasPrefix(" "){
                label = String(label.suffix(label.count - 1))
            }
            
            return label
        }
        
        func getBrand() -> String{
            return items[0].brand.capitalized
        }
    }
    
    static func ApiCall(barcode: String, completion: @escaping APIcompletion){
        // Check for valid barcode
        if barcode == "" || barcode.count != 12{
            completion(nil, APIerror.init(response: "Invalid barcode"))
            return
        }
        
        // Set queue for alamofire request
        let queue = DispatchQueue.main
        
        // Set alamofire request timeout configuration
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 10
        configuration.timeoutIntervalForRequest = 10
        UPCitemdbSessionManager = Alamofire.SessionManager(configuration: configuration)
        
        UPCitemdbSessionManager.request("https://api.upcitemdb.com/prod/trial/lookup?upc=\(barcode)").responseJSON(queue: queue) { response in
            
            response.result.ifSuccess {
                guard let data = response.data else {
                    completion(nil, APIerror.init(response: "No data returned from API call"))
                    return
                }
                
                // Try to decode data and store it in a FoodProduct struct
                do {
                    let foodProduct = try JSONDecoder().decode(FoodProduct.self, from: data)
                    completion(foodProduct, nil)
                    
                } catch {
                    do{
                        let error = try JSONDecoder().decode(APIerror.self, from: data)
                        completion(nil, error)
                        
                    } catch {
                        completion(nil, APIerror.init(response: "An unknown error has occured"))
                        return
                    }
                }
            }
            
            response.result.ifFailure {
                completion(nil, APIerror.init(response: "Secondary API request timeout"))
            }
            
            
        }
    }
}
