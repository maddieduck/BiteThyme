//
//  Walgreens.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/26/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit

let APIKey = "TI7VAqcBNatV4EhAV0Nat9cV8grR9GL9"

//affiliate IDs
let photoPrints = "photoapi"
let rxRefill = "rxapi"
let balanceRewards = "brctest"
let storeLocator = "storesapi"

class Walgreens: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    struct productInfo {
        var skuID: String  //the unique identifier for each product
        var qty: String    //The quantity of the item the customer is attempting to transfer
        var type: String   //The product type of the product. Example: "DL"
    }
    
}
