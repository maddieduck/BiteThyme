//
//  Kroger.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/22/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit
import SafariServices

let clientID = "bitethyme-748cf1203e7cf4bb6ee392215704fa843470377299293020622"
let redirectURI = "BiteThyme://callback"
let clientSecret = "70bjcPhjGpVFWQuICAB1elT7i0EjgL2XDz3V0KI7"
let header = clientID + ":" + clientSecret
let headerEncoded = Data(header.utf8).base64EncodedString()


extension List{
    
    func Authorization() {
        
        let scope = "cart.basic:write"
        let responseType = "code"   //always code
        var baseString = "https://api.kroger.com/v1/connect/oauth2/authorize?scope=" + scope + "&client_id=" + clientID + "&redirect_uri=" + redirectURI + "&response_type=" + responseType
        print(baseString)
        let session = URLSession.shared
        let url = URL(string: baseString)!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
        if let error = error {
            //print("error: \(error)")
        } else {
            if let response = response as? HTTPURLResponse {
                //print("statusCode: \(response.statusCode)")
            }
            
            if let mimeType = response?.mimeType, mimeType == "text/html",
                let data = data,
                let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    let vc = SFSafariViewController(url: URL(string: baseString)!)
                    self.present(vc, animated: true)
                }
            }
        }
        })
        task.resume()
    }
    
    enum grantType {
        case client_credentials
        case authorization_code
        case refresh_token
    }
    
    enum scope {
        case couponBasic
        case productCompact
    }
    
    func getAccessToken(authType: grantType, scope: scope?, authKey: String?){
        
        print("GET ACCESS TOKEN", authKey)
        let baseURL = "https://api.kroger.com/v1/connect/oauth2/token?grant_type="
        var finalURL = ""
        if authType == .client_credentials{
            finalURL = baseURL + "client_credentials"
            if scope == .couponBasic{
                finalURL = finalURL + "&scope=coupon.basic"
            }else{
                finalURL = finalURL + "&scope=product.compact"
            }
        }else if authType == .authorization_code{
            if authKey != nil{
                finalURL = baseURL + "authorization_code&code=" + authKey! + "&redirect_uri=" + redirectURI
            }
        }else if authType == .refresh_token{
            finalURL = baseURL + "refresh_token&refresh_token=" //refresh_token
            //TODO" Build this out
        }
        print("FINAL URL ", finalURL)
        let url = URL(string:finalURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(headerEncoded, forHTTPHeaderField: "Authorization")
        //Not sure if this is necessary
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
        
    }
    
    func getIdentity(token: String){
        let finalURL = "https://api.kroger.com/v1/identity/profile"
        let url = URL(string:finalURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
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
    
    struct itemInfo {
        var quantity: Int
        var upc: String
    }
    
    func addItemToCart(token: String, itemToAdd: itemInfo){
        let finalURL = "https://api.kroger.com/v1/cart/add"
        let url = URL(string:finalURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        // prepare json body
        let json: [String: Any] = ["items": [itemToAdd]]
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
    
    func getProductList(token: String, filterTeam: String, filterLimit: Int){
        let finalURL = "https://api.kroger.com/v1/products?filter.term=" + filterTeam + "&filter.limit" + String(filterLimit)
        let url = URL(string:finalURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    func getProductDetails(token: String, productID: String){
        let finalURL = "https://api.kroger.com/v1/products/:id?filter.locationId=" + productID
        let url = URL(string:finalURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    func getCoupons(token: String, productID: String){
        let finalURL = "https://api.kroger.com/v1/coupons?filter.productId=" + productID
        let url = URL(string:finalURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let coupon = String(data: data, encoding: .utf8) {
                    print("data: \(coupon)")
                }
            }
        }
        task.resume()
    }
    
}
