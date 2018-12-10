//
//  ProductModel.swift
//  App
//
//  Created by Sydney Schiller on 11/26/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import Foundation

protocol AddProduct {
    // call this every time the Pantry is opened
    // this will update expiration dates for each product
    func UpdateExpiration()
    
}

// FOR USE IN ShoppingListViewController
class ListStorage: Codable {
    var Lists: [List]
    
    // Standard Init
    init(){
        self.Lists = [List]()
    }
    
    // Add a new list to the array of lists
    func addToLists(list: List){
        Lists.append(list)
    }
    
    // Remove shopping list
    func removeList(index: Int){
        Lists.remove(at: index)
    }
}

// FOR USE IN IndividualListViewController AND PantryViewController
class List: Codable {
    var name: String
    var totalProducts: Int
    var products: [Product]
    
    init(){
        self.name = ""
        self.totalProducts = 0
        self.products = [Product]()
    }
    
    // for creating a new list
    init(name: String){
        self.name = name
        self.totalProducts = 0
        self.products = [Product]()
    }
    
    func returnProducts() -> String{
        var productStr: String = ""
        for product in products.dropLast(){
            productStr.append("\(product.productName), ")
        }
        productStr.append(products.last?.productName ?? "")
        return productStr
    }
    
    func GetQuantity(name: String) -> Int {
        var value : Int = 0
        products.forEach { item in
            if (item.productName == name) {
                value = item.quantity
            }
        }
        return value
    }
    
    //------------ EXPIRATION -------------
    // Need function to see how close product is to expiration date
    // if it is past expiration date, change text to red or something
}

// FOR USE IN EditItemViewController
class Product: Codable {
    // Entered by the user
    var productName: String
    var brandName: String
    // expiration date of product
    // will have to use UIDatePicker for the user to enter this
    var expDate: Date?


    // Amount stored
    var quantity: Int
    var price: String
    var daysLeft: Int
    var isExpired: Bool
    var containsPalm: Bool
    var containsDairy: Bool
    var containsNuts: Bool
    var containsWheat: Bool
    var containsSoy: Bool
    
    // Was already purchased
    var wasPurchased: Bool
    
    init(){
        self.productName = ""
        self.brandName = ""
        self.quantity = 1
        self.price = ""
        self.daysLeft = 0
        self.isExpired = false
        self.containsPalm = false
        self.containsDairy = false
        self.containsNuts = false
        self.containsWheat = false
        self.containsSoy = false
        self.wasPurchased = false
    }
    
    // for creating a new product
    // mainly used for manually entering info
    init(productName: String){
        self.productName = productName
        self.brandName = ""
        self.quantity = 1
        self.price = ""
        self.daysLeft = 0
        self.isExpired = false
        self.containsPalm = false
        self.containsDairy = false
        self.containsNuts = false
        self.containsWheat = false
        self.containsSoy = false
        self.wasPurchased = false
    }
    
    // for creating a new product with brand name
    // this could be from barcode
    init(productName: String, brandName: String){
        self.productName = productName
        self.brandName = brandName
        self.quantity = 1
        self.price = ""
        self.daysLeft = 0
        self.isExpired = false
        self.containsPalm = false
        self.containsDairy = false
        self.containsNuts = false
        self.containsWheat = false
        self.containsSoy = false
        self.wasPurchased = false
    }
    
    func calculateExpiry(date: Date){
        let currentDate = Date()
        
        
        if date < currentDate {
            print("expired")
            isExpired = true
        } else if date > currentDate {
            print("not expired")
            isExpired = false
        } else if date == currentDate {
            print("not expired")
            isExpired = false
        }
    }
    
    static func date(input: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    
        let result = dateFormatter.string(from: input)
        return result
    }
    
}
