//
//  List.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/27/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

//Displays the ingredients and stores
//The title and the "Add Item" rows have sections with 0 height (nonexistent heights)

import UIKit
import WalmartSDKKit
import WalmartOpenApi
import SafariServices

//Kroger
let krogerCallback = Notification.Name(rawValue: KrogerCallbackNotifier)
let KrogerCallbackNotifier = "KrogerCallbackNotifier"

class List: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{
    
    struct itemInfo{
        //var itemName: String
        var checked: Bool
        var groceryStoreDetails: [ingredientInfo]?
    }
    
    //itemArray is the key to the dictionary
    var itemsArray = ["milk", "eggs", "cheese","milky", "eggs ", "cheeseyyy"]
    var itemsDictionary: [String: itemInfo] = [:]
    
    var listTitle: String = ""

    @IBOutlet weak var ListTableView: UITableView!
    @IBOutlet weak var groceryListTitle: UINavigationItem!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var groceryListTitleText: UINavigationItem!
    
    var sectionsExpanded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //populate dictionary
        for item in itemsArray{
            itemsDictionary[item] = itemInfo(checked: false, groceryStoreDetails: nil)
        }
        itemsArray.append("nugget")
        itemsDictionary["nugget"] = itemInfo(checked: true, groceryStoreDetails: nil)
        itemsArray.append("thyme")
        itemsDictionary["thyme"] = itemInfo(checked: true, groceryStoreDetails: nil)
        itemsArray.append("rosemary")
        itemsDictionary["rosemary"] = itemInfo(checked: false, groceryStoreDetails: nil)
        
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
        
        //get the grocery store details
        let myGroup = DispatchGroup()
        getAccessToken(authType: .client_credentials, scope: .productCompact, authKey: nil) { (token) in
            for item in self.itemsArray{
                myGroup.enter()
                //get 2D array of products
                //shuffle the 2D array into a 1D array
                self.getGroceriesForStores(token: token ?? "", groceryItem: item) { (returnedItemInfo) in
                    //populate the dictionary
                    self.itemsDictionary[item]?.groceryStoreDetails = returnedItemInfo
                    myGroup.leave()
                }
            }
        }

        myGroup.notify(queue: DispatchQueue.main) {
            //After loaded repopulate the tableview
            self.ListTableView.reloadData()
        }
        
        //SearchCatalogItems(query: "")
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //ArrayOfItems.count
        if section == 0 || section == (itemsArray.count + 1){
            return 1
        }else{
            //each ingredient needs padding and store data
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemsArray[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //items + title + addItem at the bottom
        return itemsArray.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            //Title
            let titleCell = ListTableView.dequeueReusableCell(withIdentifier: "ListNameTVCell", for: indexPath) as! ListTitleTVCell
            titleCell.title.text = listTitle
            return titleCell
        }else if indexPath.section == (itemsArray.count + 1){
            //Add Item (Last Cell)
            //let addCell = ListTableView.dequeueReusableCell(withIdentifier: "AddTVItem", for: indexPath) as! AddIngreient
            //addToolBar(textField: addCell.addItemTextField)
            return ListTableView.dequeueReusableCell(withIdentifier: "AddTVItem", for: indexPath) as! AddIngredient
        }else if indexPath.row == 0{
            //store information
            let ingredientCell = ListTableView.dequeueReusableCell(withIdentifier: "ListTableViewCellID", for: indexPath) as! ListTableViewCell
            //ingredientCell.
            return ingredientCell
        }else{
            //Padding
            let paddingCell = ListTableView.dequeueReusableCell(withIdentifier: "PaddingTVCellID", for: indexPath) as! Padding
            return paddingCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            //Title
            return 52
        }else if indexPath.section == (itemsArray.count + 1){
            //Add Item Row
            return 36
        }
        
        let item = itemsArray[indexPath.section - 1]
        let checked = itemsDictionary[item]?.checked
        
        if sectionsExpanded == true && checked == false{
            if indexPath.row == 0{
                //Ingredient Cell
                return 135
            }else{
                //Padding
                return 20
            }
        }else{
            return 0.0001
        }

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == (itemsArray.count + 1){
            //title section is nonexistent and so is the "Add Item" section
            return 0.0001
        }else{
            //Ingredient name section
            return 36
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == (itemsArray.count + 1){
            //for the first section that is unseen
            let cell = ListTableView.dequeueReusableCell(withIdentifier: "ingredientHeader") as! ingredientHeader
            return cell
        }else{
            let headerCell = ListTableView.dequeueReusableCell(withIdentifier: "ingredientHeader") as! ingredientHeader
            let item = itemsArray[section - 1]
            let checked = itemsDictionary[item]?.checked
            headerCell.populateItemName(item: item, checked: checked ?? false)
            headerCell.isUserInteractionEnabled = true
            headerCell.delegate = self
            return headerCell
            //return headerCell.contentView
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
        print("DID SELECT ROW")
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == itemsArray.count + 1{
            print("Add Item Pressed")
        }
    }

    
    @IBAction func shoppingCartPressed(_ sender: UIButton) {
        if sectionsExpanded == true{
            //collapse cells
            groceryListTitle.title = ""
            sectionsExpanded = false
            sender.setImage(UIImage(named: "ShoppingCart"), for: .normal)
        }else{
            //expand cells
            sectionsExpanded = true
            sender.setImage(UIImage(named: "triangle"), for: .normal)
        }

        self.ListTableView.reloadData()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil && textField.text != ""{
            //ArrayOfItems.append(textField.text!)
        }
        textField.resignFirstResponder()
        return true
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

extension UIViewController: UITextFieldDelegate{
    func addToolBar(textField: UITextField){
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: "donePressed")
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: "cancelPressed")
        var spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()

        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    func donePressed(){
        view.endEditing(true)
    }
    func cancelPressed(){
        view.endEditing(true) // or do something
    }
}

