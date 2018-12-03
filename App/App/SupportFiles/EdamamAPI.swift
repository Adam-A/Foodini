//
//  EdamamAPI.swift
//  App
//
//  Created by Mark Nickerson on 12/1/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
// API:
//     - APIerror struct, returned in completion when errors arise
//     - FoodProduct struct, returned in completion when api call is successful
//     - ApiCall function, returns APIerror or FoodProduct
//         - Contains alamofire URL request (secheduled to DispatchQueue.main)


import Foundation
import Alamofire

struct API{
    
    struct APIerror: Codable {
        var error: String
        var message: String
        
        init(response: String){
            self.error = response
            self.message = response
        }
    }
    
    typealias APIcompletion = ((_ response: FoodProduct?, _ error: APIerror?) -> Void)
    typealias APIfunctionCompletion = ((_ response: [String:Bool], _ error: APIerror?) -> Void)
    
    struct FoodProduct: Codable {
        struct Hints: Codable {
            var food: Food
        }
        
        struct Food : Codable{
            var foodId: String
            var uri: String
            var label: String
            var nutrients: Nutrients
            var brand: String
            var category: String
            var categoryLabel: String
            var foodContentsLabel: String
        }
        
        struct Nutrients: Codable{
            var ENERC_KCAL: Double
        }
        
        var text: String
        var parsed: [String]
        var hints: [Hints]
        
        func getLabel() -> String{
            // Process label for a better display experience
            var label = hints[0].food.label.capitalized
            
            if label.contains(hints[0].food.brand){
                label = label.replacingOccurrences(of: hints[0].food.brand, with: "")
            }
            
            if label.hasPrefix(" "){
                label = String(label.suffix(label.count - 1))
            }
            
            return label
        }
        
        func getBrand() -> String{
            return hints[0].food.brand.capitalized
        }
        
        // .contains is has an O(n) runtime, so put it in a background thread
        func getAllergins(completion: @escaping APIfunctionCompletion){
            let allerginsQueue = DispatchQueue(label: "Allergen Processing Queue")
        
            allerginsQueue.async {
                let group = DispatchGroup()
                let foodContents = self.hints[0].food.foodContentsLabel.lowercased()
                var allergins: [String:Bool] = ["palm" : false, "dairy" : false, "nuts" : false, "wheat" : false, "soy" : false]
                
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    if foodContents.contains("palm"){
                        allergins["palm"] = true
                    }
                    group.leave()
                }
                
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    if foodContents.contains("milk") || foodContents.contains("dairy"){
                        allergins["dairy"] = true
                    }
                    group.leave()
                }
                
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    if foodContents.contains("nut"){
                        allergins["nuts"] = true
                    }
                    group.leave()
                }
                
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    if foodContents.contains("wheat"){
                        allergins["wheat"] = true
                    }
                    group.leave()
                }
                
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    if foodContents.contains("soy"){
                        allergins["soy"] = true
                    }
                    group.leave()
                }
                
                group.wait()
                
                DispatchQueue.main.async {
                    completion(allergins, nil)
                }
            }
        }
    }
    
    static func ApiCall(barcode: String, completion: @escaping APIcompletion){
        // Check for valid barcode
        if barcode == "" || barcode.count != 12{
            completion(nil, APIerror.init(response: "Invalid barcode"))
            return
        }
        
        // Set verificaton IDs
        let appID = "9ca52e0d"
        let appKey = "7dade37c47154913ca172a01f0e48921"
        
        // Set queue for alamofire request
        let queue = DispatchQueue.main
        
        Alamofire.request("https://api.edamam.com/api/food-database/parser?upc=\(barcode)&app_id=\(appID)&app_key=\(appKey)").responseJSON(queue: queue) { response in
            
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
    }
    
    // An attempt to get the RecipeCall to work: still gets 401 error, need to check appID and appKey before proceeding
//    static func RecipeCall(){
//        let appID = "57137e17"
//        let appKey = "630a79c36b59b59acca9fa0461eb2329"
//        let queue = DispatchQueue.main
//
//        Alamofire.request("https://api.edamam.com/search?q=chicken&app_id=\(appID)&app_key=\(appKey)&from=0&to=3&calories=591-722&health=alcohol-free").responseJSON(queue: queue) { response in
//
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
//
//        }
//    }
}
