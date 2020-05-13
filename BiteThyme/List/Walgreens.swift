//
//  Walgreens.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/26/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit


//affiliate IDs
enum affiliateID {
    case photoapi
    case rxapi
    case brctest
    case storesapi
}

extension List{
    
//    struct productInfo {
//        var skuID: String  //the unique identifier for each product
//        var qty: String    //The quantity of the item the customer is attempting to transfer
//        var type: String   //The product type of the product. Example: "DL"
//    }
    
    func searchStoreByGeoLocation(){
        let baseURL = "https://services.walgreens.com/api/stores/search/v1"
        let url = URL(string:baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let APIKey = "TI7VAqcBNatV4EhAV0Nat9cV8grR9GL9"

        //JSON body
        let json: [String : Any] = ["apiKey": APIKey, "affId": "storesapi", "lat": 41, "lng": -87, "r": 10, "requestType": "locator"] //, "appVer": "#.#", "devInf":"DEVICE,##.#"
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
    
    func searchStoreByAddress() {
        let baseURL = "https://services.walgreens.com/api/stores/search/v1"
        let url = URL(string:baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let APIKey = "TI7VAqcBNatV4EhAV0Nat9cV8grR9GL9"

        //JSON body
        let json: [String : Any] = ["apiKey": APIKey, "affId": "storesapi", "address": "2417 Canyon Creek Dr.", "r": "10", "requestType": "locator"] //, "appVer": "#.#", "devInf":"DEVICE,##.#"
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
    
    func searchStoreByZipcode(){
        
    }
    
}
