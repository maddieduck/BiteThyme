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
let privateKey = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDWuFQP6Sdd9Nvig152x1Y4cniGmWTcS5altEhVUf6CSpIGaMWWu8ey7DU6TZ0+EDbotZ2PllQ48MfSe29SmngwVPCc633gSIu93xZQEJJ3SPTr9VR2nuZcSXXyZenv3LZrSk9kxparxEqBCGwrvVQqFKENAj58LV3855ZT4jU3X9wnaABix1eZNYPhkzfDP1V4hdb+LJcAIF3zEfnvEDPuW11Ghu2ORFWY0zfD2n77Hkr+N7eMZQVlr3ArdnLbiDee5yTfiQD5ksXUjJfxYzVuE1Z6QBotasEyzoDyuFQo0QRH+K6R8+ok5Ag3EkmvOMEUj/3YITeWhDhwvsTihBljAgMBAAECggEARjpVrDqK2K0seeKTs++woJe4GfXzyiWi6SGVAurlfkHbjuMXtRxHzZp6Mk6OXm05OFWmaf82HsWJ5arflznUk6JEbF6NdhzkL77WcmtpLECdcstzy7RfDdItFJIGuKAMvfy5CPH298kkwR07G/c5nuXOYw3X2A+SjRRF07vJwgkr6nAEl8dF2njhsPiO6rIkqBgRUpks+typgohyDW1HCjA++z3ksKFZsyPyQ7KTyxykEhWXopKERtRarz1DCr5FNyOxkip/k6EkmlwLUJFb1cVpZwxkl+A+afA0ACH3D6IDok5s6T1oDCo9hv/9xum5gzZgwZQ8OVyrPEwWMhHXIQKBgQDyShyyVoB0J+Bg+xnbBMhfvoUpgG4C4QT44yhAQMAJ9SumUMR4VNqPHYAuZG+Pf0BRSF/tTNl4Snkf/vTiCUiVU0l2eg4qEL3qmPc5EuTDjlOo1Y7P3dzASeFLPSbkRljS7gP2v5LiOUXfMtjkbRiSP/tL6i63fYyG5fEmFsbf0wKBgQDi3tXqexw+fOWJx59CT5iotvjvAMQdADDN5W6VyyC7fooZEQ0RMdc93vIjNbnu4ONxdHhzpZ7vxqK58lgMVisLadte56ibxAzUsaIU+E6MWaw4j04POaEPrmj6CZ+7CQt1sqUB33cAtj2gwUbq80iOssJjwCVI47PisDqecph2MQKBgH55VVV6df8sOaImMS705iukZhpt4f86ur+4w/AWXKhWBH0CuCwgDx6Zxalx4BJF2KsVXo2eif6S0Xt0ORwswGjCWxyvRemLZ7eoNZTjWesCxoThRXUYWP0/E42U1FJgrkkc2ZDaG7BfOSvzfOhwUl01bNYJ3m0F6m8YZLL/PLzlAoGBAN3cgWGvRy2swmR8/TfB006asNI5849Q0mloBz8hyD7TPoXI8Phxv0ZYMn9QWSZMcuBOwESIIOfnXtdtMcHOuoWM3eTvsymxDcMqe5D6SwZh41PkgLfO6b0GGM78fmJQNA7Dxy4PtLbTgW0l1g6KH9i84/DcxRmE5DO5l3nAI2zhAoGAIOXKWzp4TTRukKju3rnKB1Pj/7lkaEwWx1Q4mocGieuoeSWJwvZUDlbEeEd+RvvjJKg5Jmrq+SaupyQRjxIhdz3k77BIIh2Nc09/1otNr3+Fnkhw5hUDH27MrumTUPJtpIfU0df02FQajOI7SxuH5WJcjywzjsFKpdQ71gNA6yM="

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
        let apiInstance = WMTOAProductLookupApi()
//
//        apiInstance.getItemWithItemId(itemId, apiKey: apiKey, lsPublisherId: lsPublisherId, format: format) { (output, error) in
//            if (output != nil) {
//                print(output)
//            }
//            if (error != nil) {
//                print(error)
//            }
//        }
        
//        let a = WMTOAItem()
//        a.affiliateAddToCartUrl()
//
//        let b = WMTOASearchApi()
//        b.defaultHeader(forKey: <#T##String!#>)
        
        print("RUNNING")
        searchProduct(query: "cheese")
    }
    
    func searchProduct(query: String){
        let finalURL = "https://developer.api.walmart.com/api-proxy/service/affil/product/search?query=" + query
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
        let authSig = authenticationSignature()
        request.setValue(authSig, forHTTPHeaderField: "WM_SEC.AUTH_SIGNATURE")
        
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
    
    func authenticationSignature() -> String{
        var headerDictionary: [String: String] = [:]
        headerDictionary["WM_CONSUMER.ID"] = consumerId
        let timeStamp = NSDate().timeIntervalSince1970
        headerDictionary["WM_CONSUMER.INTIMESTAMP"] = timeStamp.stringFromTimeInterval()
        headerDictionary["WM_SEC.KEY_VERSION"] = keyVersion
        
        var canonicalizedArray = canonicalizeArray(dictionary: headerDictionary)
        
        return ""
    }

    func canonicalizeArray(dictionary: [String: String]) -> [String] {
        return [""]
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
