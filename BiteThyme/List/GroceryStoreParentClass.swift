//
//  GroceryStoreParentClass.swift
//  BiteThyme
//
//  Created by Maddie Drake on 6/28/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import Foundation

struct ingredientInfo {
    var itemName: String
    var itemPicture: String
    var price: Double
}

class GroceryStore{
    
    //returns a struct of
    func itemInformation(itemName: String) -> [ingredientInfo]?{
        print("Error in itemInformation. Grocery store does not exist.")
        return nil
    }
    
}
