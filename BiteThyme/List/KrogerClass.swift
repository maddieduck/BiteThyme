//
//  KrogerClass.swift
//  BiteThyme
//
//  Created by Maddie Drake on 6/28/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import Foundation

class Kroger: GroceryStore{
    
    override func itemInformation(itemName: String) -> [ingredientInfo]?{
        print("Error in itemInformation. Grocery store does not exist.")
        return nil
    }
    
}

