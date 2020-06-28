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
    
    func checkboxClicked(ingredient: String) {
        let oldCheckedValue = itemsDictionary[ingredient]?.checked
        if oldCheckedValue != nil{
            let newCheckedValue = !oldCheckedValue!
            print("NEW CHECKED ", newCheckedValue)
            itemsDictionary[ingredient]?.checked = newCheckedValue
            //itemsDictionary.updateValue(<#T##value: itemInfo##itemInfo#>, forKey: <#T##String#>)
        }
        print("CHECKBOX CLICKED")
        ListTableView.beginUpdates()
        ListTableView.endUpdates()
    }
    
}
