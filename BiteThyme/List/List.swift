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
    
    let ArrayOfItems = ["milk", "eggs", "cheese", "yogurt", "posicles", "candy", "cucumber", "nuts"]
    var listTitle: String = ""
    
    @IBOutlet weak var ListTableView: UITableView!
    @IBOutlet weak var groceryListTitle: UINavigationItem!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var groceryListTitleText: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Use this for the callback when using the authorization code and adding things to carts
        NotificationCenter.default.addObserver(forName: krogerCallback, object: nil, queue: nil) { (Notification) in
            //Kroger has given an Auth key and now we have to get the access token
            print("OBSERVER ", Notification.object)
            self.dismiss(animated: true)

        }
        
        Utilities.styleFilledButton(checkoutButton)
        
        //gets rid of the header view
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        ListTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 0.1))
        
        // Sets Bar's Background Image (Color) //
        navbar.setBackgroundImage(UIImage.imageWithColor(color: .blue), for: .default)
        // Sets Bar's Shadow Image (Color) //
        navbar.shadowImage = UIImage.imageWithColor(color: .red)
        navbar.setValue(true, forKey: "hidesShadow")
        
        //searchProduct(query: "Cheese")
        
        //Get the Kroger products for all elements in the array
        //THIS WORKS 
//        getAccessToken(authType: .client_credentials, scope: .productCompact, authKey: nil) { (token) in
//            if token != nil{
//                let myGroup = DispatchGroup()
//                var ArrayOfProductData: [productListData] = []
//                for ingr in self.ArrayOfItems{
//                    myGroup.enter()
//                    self.getProductList(token: token!, filterTerm: ingr, filterLimit: 10) { (productData) in
//                        //print("INGR DESCRIPTION ", productData!.data![0].description )
//                        //print("appending")
//                        ArrayOfProductData.append(productData!)
//                        myGroup.leave()
//                    }
//                }
//                myGroup.notify(queue: .main) {
//                    //print("Finished getting product data for all ingredients")
//                    for ingr in ArrayOfProductData{
//                        //print("INGR DESCRIPTION ", ingr.data![0].description )
//                    }
//                }
//            }
//        }
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //ArrayOfItems.count
        if section == 0{
            return 1
        }else if section == ArrayOfItems.count{
            //the last cell doesn't need padding
            return 1
        }else{
            //each ingredient needs padding and store data
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ArrayOfItems[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ArrayOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let titleCell = ListTableView.dequeueReusableCell(withIdentifier: "ListNameTVCell", for: indexPath) as! ListTitleTVCell
            titleCell.title.text = listTitle
            return titleCell
        }else if indexPath.row == 0{
            let ingredientCell = ListTableView.dequeueReusableCell(withIdentifier: "ListTableViewCellID", for: indexPath) as! ListTableViewCell
            return ingredientCell
        }else{
            return ListTableView.dequeueReusableCell(withIdentifier: "PaddingTVCellID", for: indexPath) as! Padding
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            //Title
            return 52
        }else if indexPath.row == 0{
            //Ingredient Cell
            return 135
        }else{
            //Padding
            return 20
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            //title section is nonexistent
            return 0
        }else{
            //Ingredient name section
            return 36
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            //for the first section that is unseen
            return ListTableView.dequeueReusableCell(withIdentifier: "ingredientHeader") as! ingredientHeader
        }else{
            let headerCell = ListTableView.dequeueReusableCell(withIdentifier: "ingredientHeader") as! ingredientHeader
            headerCell.ingredient.text = ArrayOfItems[section - 1]
            return headerCell.contentView
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let titleIndexPath = IndexPath(row: 0, section: 0)
        let cellRect = ListTableView.rectForRow(at: titleIndexPath)
        let completelyInvisible = ListTableView.bounds.intersects(cellRect)
        if completelyInvisible{
            groceryListTitle.title = ""
        }else{
            groceryListTitle.title = listTitle
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

