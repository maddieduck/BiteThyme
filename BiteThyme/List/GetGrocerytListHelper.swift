//
//  getGrocertListHelper.swift
//  BiteThyme
//
//  Created by Maddie Drake on 7/1/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import Foundation

extension List{

    func getGroceriesForStores(token: String, groceryItem: String, completion: @escaping ([ingredientInfo]?) -> ()){
        //read in which stores were chosen by the user
        //get ingredient data for each store
        
        //Get the Kroger products for an item
        self.getProductList(token: token, filterTerm: groceryItem, filterLimit: 10) { (productData) in
            print("GET PROD LIST EXECUTING")
            if productData == nil{
                completion(nil)
            }
            if productData!.data == nil{
                completion(nil)
            }
            var ingredientArray:[ingredientInfo] = []
            for products in productData!.data!{
                let itemName = products.description
                let itemPicture = products.images?[0].sizes?[0].url
                //TODO Item Price
                let itemPrice = 0.0
                let ingInfo = ingredientInfo(itemName: itemName ?? "", itemPicture: itemPicture ?? "", price: itemPrice)
                        ingredientArray.append(ingInfo)
                        //productData.data![0].description
            }

            if ingredientArray.count == nil{
                completion(nil)
            }else{
                completion(ingredientArray)
            }
        }
    }
}
