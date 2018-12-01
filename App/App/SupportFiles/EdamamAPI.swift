//
//  EdamamAPI.swift
//  App
//
//  Created by Mark Nickerson on 12/1/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import Foundation

// Food Product structure (put into API.swift)
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
    
}

struct APIerror: Codable {
    var error: String
    var message: String
}
