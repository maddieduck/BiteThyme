//
//  ViewController.swift
//  Bite Thyme
//
//  Created by Maddie Drake on 4/11/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit
import Foundation
import WebKit

let clientID = "bitethyme-748cf1203e7cf4bb6ee392215704fa843470377299293020622"
let redirectURI = "https://bitethyme.com"
let clientSecret = "70bjcPhjGpVFWQuICAB1elT7i0EjgL2XDz3V0KI7"
let header = clientID + ":" + clientSecret
let headerEncoded = Data(header.utf8).base64EncodedString()
//let secondEncoded = (header.data(using: .utf8))?.base64EncodedString()

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
        
    @IBOutlet weak var webSquare: WKWebView!
    @IBOutlet weak var webSquareTwo: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webSquare.navigationDelegate = self
    }


    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let url:URL = URL(string: "https://www.apple.com")!
//        let urlRequest: URLRequest = URLRequest(url: url)
//        webSquare.load(urlRequest)
    }
    
    @IBAction func Authorize(_ sender: Any) {
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
                    self.webSquare.loadHTMLString(string, baseURL: url)
                    //print("STRING", string, "URL", url)
                    //self.webSquareTwo.loadHTMLString(string, baseURL: url)
                }
            }
        }
        })
        task.resume()
    }
    
    @IBAction func AccessToken(_ sender: Any) {
        let url = URL(string: "https://api.kroger.com/v1/connect/oauth2/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(headerEncoded, forHTTPHeaderField: "Authorization")
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // prepare json body
        let json: [String: Any] = ["grant_type": "authorization_code", "code": "authorization" , "redirect_uri": redirectURI]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
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
    
    @IBAction func GetProductList(_ sender: Any) {
        let term = "milk"
        let locationID = ""
        let productID = ""
        let brand = ""
        let fullfillment = ""
        let start: Int = 1
        let limit: Int = 10
        let baseString = "https://api.kroger.com/v1/products?filter.term=" //+ term + "&filter.locationId=" + locationID + ">&filter.productId=" + productID + "&filter.brand=" + brand + "&filter.fulfillment=" + fullfillment + "&filter.start=" + String(start) + "&filter.limit=" + String(limit)
        print(baseString)
        let session = URLSession.shared
        let url = URL(string: baseString)!
        //session.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
        // Check the response
                print(error)
                print(response)
        })
        task.resume()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("EXECUTING decide policy for ", webView.url)
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        print("EXECUTING decide policy for 2", webView.url)
        
        decisionHandler(.allow, .init())
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("DID FINISH NAV")
    }
    
}

