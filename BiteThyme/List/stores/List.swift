//
//  List.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/27/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit
import WalmartSDKKit
import WalmartOpenApi
import SafariServices

//Kroger
let krogerCallback = Notification.Name(rawValue: KrogerCallbackNotifier)
let KrogerCallbackNotifier = "KrogerCallbackNotifier"


class List: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ArrayOfItems = ["milk", "eggs", "cheese"]
    
    @IBOutlet weak var ListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Use this for the callback when using the authorization code and adding things to carts
        NotificationCenter.default.addObserver(forName: krogerCallback, object: nil, queue: nil) { (Notification) in
            //Kroger has given an Auth key and now we have to get the access token
            print("OBSERVER ", Notification.object)
            self.dismiss(animated: true)

        }
        
        //searchStoreByGeoLocation()
        //searchStoreByAddress()
        
        //searchProduct(query: "Cheese")

        
        //Get the Kroger products for all elements in the array
        getAccessToken(authType: .client_credentials, scope: .productCompact, authKey: nil) { (token) in
            if token != nil{
                let myGroup = DispatchGroup()
                var ArrayOfProductData: [productListData] = []
                for ingr in self.ArrayOfItems{
                    myGroup.enter()
                    self.getProductList(token: token!, filterTerm: ingr, filterLimit: 10) { (productData) in
                        //print("INGR DESCRIPTION ", productData!.data![0].description )
                        print("appending")
                        ArrayOfProductData.append(productData!)
                        myGroup.leave()
                    }
                }
                myGroup.notify(queue: .main) {
                    print("Finished getting product data for all ingredients")
                    for ingr in ArrayOfProductData{
                        print("INGR DESCRIPTION ", ingr.data![0].description )
                    }
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //ArrayOfItems.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ArrayOfItems[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ArrayOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListTableView.dequeueReusableCell(withIdentifier: "ListTableViewCellID", for: indexPath) as! ListTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
