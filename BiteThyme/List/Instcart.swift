//
//  Instcart.swift
//  BiteThyme
//
//  Created by Maddie Drake on 6/23/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import Foundation

extension List{

    func SearchCatalogItems(query: String){
        //print("SEARCH CATALOG")
        //let finalURL = "https://api.impact.com/Mediapartners/" + accountSID + "/Catalogs/ItemSearch?Query=%3C" + query
        let finalURL = "https://api.impact.com/Mediapartners/" + accountSID + "/Catalogs/ItemSearch"
        //print("finalURL ", finalURL)
        let session = URLSession.shared
        let url = URL(string: finalURL)!
        var request = URLRequest(url: url)
        let requestMethod = "GET"
        request.httpMethod = requestMethod
        
        //authenticate
        //request.setValue(accountSID, forHTTPHeaderField: "UserName")
        //request.setValue(authToken, forHTTPHeaderField: "Password")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    //print("statusCode: \(response.statusCode)")
                }
                if let data = data, let identity = String(data: data, encoding: .utf8) {
                    //print("data: \(identity)")
                }
            }
        }
        task.resume()
        
    }

}

