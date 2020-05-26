////
////  ViewController.swift
////  Bite Thyme
////
////  Created by Maddie Drake on 4/11/20.
////  Copyright © 2020 Maddie Drake. All rights reserved.
////
//
//import UIKit
//import Foundation
//import WebKit
//import SafariServices
//
//class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate{
//
//    //@IBOutlet weak var webSquare: WKWebView!
//    //@IBOutlet weak var webSquareTwo: UIWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        //webSquare.navigationDelegate = self
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
////        super.viewDidAppear(animated)
////        let url:URL = URL(string: "https://www.apple.com")!
////        let urlRequest: URLRequest = URLRequest(url: url)
////        webSquare.load(urlRequest)
//    }
//
//    @IBAction func Autrh(_ sender: Any) {
//        let scope = "cart.basic:write"
//        let responseType = "code"   //always code
//        var baseString = "https://api.kroger.com/v1/connect/oauth2/authorize?scope=" + scope + "&client_id=" + clientID + "&redirect_uri=" + redirectURI + "&response_type=" + responseType
//        print(baseString)
//        let session = URLSession.shared
//        let url = URL(string: baseString)!
//
//        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//        if let error = error {
//            //print("error: \(error)")
//        } else {
//            if let response = response as? HTTPURLResponse {
//                //print("statusCode: \(response.statusCode)")
//            }
//
//            if let mimeType = response?.mimeType, mimeType == "text/html",
//                let data = data,
//                let string = String(data: data, encoding: .utf8) {
//                DispatchQueue.main.async {
//                    //self.webSquare.loadHTMLString(string, baseURL: url)
//                    //self.webSquareTwo.loadHTMLString(string, baseURL: url)
//                }
//            }
//        }
//        })
//        task.resume()
//    }
//    @IBAction func Authorize(_ sender: Any) {
//        let scope = "cart.basic:write"
//        let responseType = "code"   //always code
//        var baseString = "https://api.kroger.com/v1/connect/oauth2/authorize?scope=" + scope + "&client_id=" + clientID + "&redirect_uri=" + redirectURI + "&response_type=" + responseType
//        print(baseString)
//        let session = URLSession.shared
//        let url = URL(string: baseString)!
//
//        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//        if let error = error {
//            //print("error: \(error)")
//        } else {
//            if let response = response as? HTTPURLResponse {
//                //print("statusCode: \(response.statusCode)")
//            }
//
//            if let mimeType = response?.mimeType, mimeType == "text/html",
//                let data = data,
//                let string = String(data: data, encoding: .utf8) {
//                DispatchQueue.main.async {
//                    //self.webSquare.loadHTMLString(string, baseURL: url)
//                    //self.webSquareTwo.loadHTMLString(string, baseURL: url)
//                }
//            }
//        }
//        })
//        task.resume()
//    }
//
//    @IBAction func GetProductList(_ sender: Any) {
//        let term = "milk"
//        let locationID = ""
//        let productID = ""
//        let brand = ""
//        let fullfillment = ""
//        let start: Int = 1
//        let limit: Int = 10
//        let baseString = "https://api.kroger.com/v1/products?filter.term=" //+ term + "&filter.locationId=" + locationID + ">&filter.productId=" + productID + "&filter.brand=" + brand + "&filter.fulfillment=" + fullfillment + "&filter.start=" + String(start) + "&filter.limit=" + String(limit)
//        print(baseString)
//        let session = URLSession.shared
//        let url = URL(string: baseString)!
//        //session.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
//
//        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//        // Check the response
//                print(error)
//                print(response)
//        })
//        task.resume()
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        print("EXECUTING decide policy for ", webView.url)
//        //error 403 here
//        //print(navigationResponse)
//        decisionHandler(.allow)
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
//        print("EXECUTING decide policy for 2", webView.url)
//        //navigationAction.request.setValue(headerEncoded, forHTTPHeaderField: "Authorization")
//        decisionHandler(.allow, .init())
//    }
//
//
//}
//
