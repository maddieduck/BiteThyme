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

let keyVersion = "2"
let consumerId = "13c8234e-f5dc-4952-9b26-a938bf98b3be"//for Walmart IO?
var authSignature = ""
let publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx4mO05BkOt4/+W/5TgU9jyzG2F+GEG5L7z4DNPXSLQhBGXKq2XYq4p4iOcT1LxWaAAMmmCVi+dTKAb4nR85cX36YahRVK3qQfLmFM1qLrTm/Kq2MdJ9bZKxqSUBAxhQeRhrJ0YtpZCV8d2plceeeLL+TQNyAR6hBVSaFPkk6YepYKyky6Pq3XxWRNtO9jfy3WsPRixxxE84RtZTOi8Vg3YrmxzOtWuyz3Eybe6lXBOIhyo0x2xEMEcD9Mv18lpquURGuPaVtiYmu9SFl1bPzQCSzuZIBsr2FgrAesJa9QVzxcTsQizBtHfHgUGse4oBe9KWA5tZcheW0euiqzq5+9wIDAQAB"

let privateKey = "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"


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
