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
        
    enum authorizationCustomerScope {
        case profileCompact
        case cartBasicWrite
        case couponBasic
        case productCompact
        case NA
    }
    
    //When making an API request that is either returning personalized customer data or acting on behalf of a customer
    func AuthorizationCustomerContext(scope: authorizationCustomerScope) {
        //TODO build case for each
        var scopeChosen = ""
        if scope == .profileCompact{
            scopeChosen = "profile.compact"
        }else if scope == .cartBasicWrite{
            scopeChosen = "cart.basic:write"
        }else{
            scopeChosen = "coupon.basic"
        }
        let responseType = "code"   //always code
        var baseString = "https://api.kroger.com/v1/connect/oauth2/authorize?scope=" + scopeChosen + "&client_id=" + clientID + "&redirect_uri=" + redirectURI + "&response_type=" + responseType
        //print(baseString)
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
        case cartBasicWrite
        case profileCompact
        case NA
    }
    
    struct accessTokenData: Decodable {
        let expires_in: Int
        let access_token: String
        let token_type: String
    }
    
    func getAccessToken(authType: grantType, scope: scope?, authKey: String?, completion: @escaping (String?) -> ()){
        
        print("GET ACCESS TOKEN")
        let baseURL = "https://api.kroger.com/v1/connect/oauth2/token?grant_type="
        var finalURL = ""
        if authType == .client_credentials{
            finalURL = baseURL + "client_credentials"
            if scope == .couponBasic{
                finalURL = finalURL + "&scope=coupon.basic"
            }else if scope == .productCompact{
                finalURL = finalURL + "&scope=product.compact"
            }
        }else if authType == .authorization_code{
            if scope == .profileCompact{
                finalURL = finalURL + "&scope=profile.compact"
            }else if scope == .cartBasicWrite{
                finalURL = finalURL + "&scope=cart.basic:write"
            }else if scope == .couponBasic{
                finalURL = finalURL + "&scope=coupon.basic"
            }else if scope == .productCompact{
                finalURL = finalURL + "&scope=product.compact"
            }
        }else if authType == .refresh_token{
            finalURL = baseURL + "refresh_token&refresh_token=" //refresh_token
            //TODO" Build this out
        }
        //print("FINAL URL ", finalURL)
        let url = URL(string:finalURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic " + headerEncoded, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        
        //request.httpBody =
        
        //JSON body
//        let json = ["grant_type":"authorization_code"] //, "code": authKey, "redirect_uri": redirectURI]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
                completion(nil)
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                    completion(nil)
                }
            
                if let data = data{
                    let decodedData: accessTokenData = try! JSONDecoder().decode(accessTokenData.self, from: data)
                    completion(decodedData.access_token)
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
    
    struct krogerItemInfo {
        var quantity: Int
        var upc: String
    }
    
    func addItemToCart(token: String, itemToAdd: krogerItemInfo){
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
    
    struct productListData: Decodable {
        let data: [productInfo]?
    }
    
    struct productInfo: Decodable {
        let productId: String?
        let upc: String?
        let aisleLocations: [String]?
        let brand: String?
        let categories: [String]?
        let description: String?
        let images: [imageDetails]?
    }
    
    struct imageDetails: Decodable {
        let perspective: String?
        let featured: Bool?    //possibly boolean
        let sizes: [sizeDetails]?
        let items: [itemDetails]?
        //let krogerItemInfo: //not sure what this is
        //let temperature:  //don't need this rn
    }
    
    struct sizeDetails: Decodable {
        let size: String?
        let url: String?
    }
    
    struct itemDetails: Decodable {
        let itemId: String?
        let favorite: String?
        let fulfillment: fulfillmentDetails?
        let size: String?
    }
    
    struct fulfillmentDetails: Decodable {
        let curbside: String?
        let delivery: String?
        let inStore: String?
        let shipToHome: String?
    }

    func getProductList(token: String, filterTerm: String, filterLimit: Int, completion: @escaping (productListData?) -> ()){
        let finalURL = "https://api.kroger.com/v1/products?filter.term=" + filterTerm + "&filter.limit" + String(filterLimit)
        let url = URL(string:finalURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        //print(token)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }

                if let data = data{
                    //print(String(data: data, encoding: .utf8))
                    let decodedData: productListData = try! JSONDecoder().decode(productListData.self, from: data)
                    completion(decodedData)
                }else{
                    completion(nil)
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
