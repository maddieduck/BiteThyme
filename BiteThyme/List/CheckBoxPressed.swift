//
//  ListExtension.swift
//  BiteThyme
//
//  Created by Maddie Drake on 5/28/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import Foundation
import UIKit

extension List: IngredientHeaderDelegate{

    func checkBoxButtonPressed(ingredient: String) {
        let oldCheckedValue = itemsDictionary[ingredient]?.checked
        if oldCheckedValue != nil{
            let newCheckedValue = !oldCheckedValue!
            itemsDictionary[ingredient]?.checked = newCheckedValue
        }else{
            print("ERROR. checkBoxPressed function, ingredient cannot be found in dictionary")
        }
        ListTableView.reloadData()
    }

}
