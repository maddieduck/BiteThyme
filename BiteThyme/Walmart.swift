//
//  Walmart.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/21/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit
import WalmartSDKKit
import WalmartOpenApi
import SafariServices

let keyVersion = "1"
let consumerId = "13c8234e-f5dc-4952-9b26-a938bf98b3be"//for Walmart IO?
var authSignature = ""
let publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx4mO05BkOt4/+W/5TgU9jyzG2F+GEG5L7z4DNPXSLQhBGXKq2XYq4p4iOcT1LxWaAAMmmCVi+dTKAb4nR85cX36YahRVK3qQfLmFM1qLrTm/Kq2MdJ9bZKxqSUBAxhQeRhrJ0YtpZCV8d2plceeeLL+TQNyAR6hBVSaFPkk6YepYKyky6Pq3XxWRNtO9jfy3WsPRixxxE84RtZTOi8Vg3YrmxzOtWuyz3Eybe6lXBOIhyo0x2xEMEcD9Mv18lpquURGuPaVtiYmu9SFl1bPzQCSzuZIBsr2FgrAesJa9QVzxcTsQizBtHfHgUGse4oBe9KWA5tZcheW0euiqzq5+9wIDAQAB"

let publisherID = "2263813"

let accountSID = "IRfSder34g3w2263813CpmKNEp5yx4vww1"
let authToken = "bPSuMkQL9MJzJT9YTPPpzvYUX.CS~uLE"
let readOnlySID = "IRQBFT9K7Lp22263813bRhTUc37WaEqaf1"
let readOnlyAuthToken = "msg.paw5jkivqBUAJGBqta.d9DWrUPXP"
let APIVersion = "11 (2018-05-30)"



class Walmart: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let itemId = "itemId_example" //
//        let apiKey = "apiKey_example" // Your API access key
//        let lsPublisherId = "lsPublisherId_example" // Your Rakuten access key (optional)
//        let format = "json" // Type of response required, (currently only JSON supported)
//        let apiInstance = WMTOAProductLookupApi()
//
//        apiInstance.getItemWithItemId(itemId, apiKey: apiKey, lsPublisherId: lsPublisherId, format: format) { (output, error) in
//            if (output != nil) {
//                print(output)
//            }
//            if (error != nil) {
//                print(error)
//            }
//        }
        print("RUNNING")
        searchProduct(query: "cheese")
    }
    
    func searchProduct(query: String){
        let finalURL = "https://developer.api.walmart.com/api-proxy/service/affil/product/search?publisherId=" + publisherID + "&query=" + query
        print("finalURL ", finalURL)
        let session = URLSession.shared
        let url = URL(string: finalURL)!
        var request = URLRequest(url: url)
        let timeStamp = NSDate().timeIntervalSince1970
        
        //make the signature
        
        //signatureBytes =
        //signatureString = Data(signatureBytes.utf8).base64EncodedString()
        
        request.setValue(keyVersion, forHTTPHeaderField: "WM_SEC.KEY_VERSION")
        request.setValue(consumerId, forHTTPHeaderField: "WM_CONSUMER.ID")
        request.setValue(timeStamp.stringFromTimeInterval(), forHTTPHeaderField: "WM_CONSUMER.INTIMESTAMP")
        request.setValue("application/json", forHTTPHeaderField: "WM_SEC.AUTH_SIGNATURE")
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            if let data = data {
               if let jsonString = String(data: data, encoding: .utf8) {
                  print("JSON STRING ", jsonString)
               }
            }else{
                print("DATA IS NIL ")
            }
        })
        task.resume()
    }
    
    
    
}

extension TimeInterval{

    func stringFromTimeInterval() -> String {

        let time = NSInteger(self)

        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)

    }
}
