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
class ListStorage {
    var ListName: String
    var Lists: [List]
    
    // Standard Init
    init(){
        self.ListName = "List"
        self.Lists = [List]()
    }
    
    // for creating customized list name
    init(ListName: String){
        self.ListName = ListName
        self.Lists = [List]()
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
    // current date that will be used to see if product is close to expiring
    var currentDate: Date
    // Amount stored
    var quantity: Int
    var price: String
    var daysLeft: Int
    // ------ enter more to hold response from Edamam-----
    
    init(){
        self.productName = ""
        self.brandName = ""
        self.quantity = 1
        self.price = ""
        self.daysLeft = 0
        self.currentDate = Date()
    }
    
    // for creating a new product
    // mainly used for manually entering info
    init(productName: String){
        self.productName = productName
        self.brandName = ""
        self.quantity = 1
        self.price = ""
        self.daysLeft = 0
        self.currentDate = Date()
    }
    
    // for creating a new product with brand name
    // this could be from barcode
    init(productName: String, brandName: String){
        self.productName = productName
        self.brandName = brandName
        self.quantity = 1
        self.price = ""
        self.daysLeft = 0
        self.currentDate = Date()
    }
    
}
