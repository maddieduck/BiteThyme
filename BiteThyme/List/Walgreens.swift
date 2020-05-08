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
let photoPrintsAffID = "photoapi"
let rxRefillAffID = "rxapi"
let balanceRewardsAffID = "brctest"
let storeLocatorAffID = "storesapi"

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
    
    enum storeSearchType {
        case Geolocation
        case Address
        case Zipcode
    }
    
    func searchByGeolocation(){
        
    }
    
    func searchByAddress(){
        
    }
    
    func searchByZipcode(){
        
    }
    
    func storeLocator(){
        let baseURL = "https://services.walgreens.com/api/stores/search/v1"
        let url = URL(string:baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let affiliateID = ""
        //JSON body
        let json = ["apiKey":APIKey, "affId": affiliateID] //, "code": authKey, "redirect_uri": redirectURI]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let identity = String(data: data, encoding: .utf8) {
                    print("data: \(identity)")
                }
            }
        }
        task.resume()
    }
    
}
