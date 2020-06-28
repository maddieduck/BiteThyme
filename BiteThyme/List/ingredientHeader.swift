//
//  ingredientHeader.swift
//  
//
//  Created by Maddie Drake on 5/25/20.
//

import UIKit

protocol IngredientHeaderDelegate {
    func checkBoxButtonPressed(ingredient:String)
}

class ingredientHeader: UITableViewCell {

    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var ingredient: UITextField!
    
    var delegate: IngredientHeaderDelegate?
    var checkedOff: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func checkboxPressed(_ sender: Any) {
        print("check pressed")
        delegate?.checkBoxButtonPressed(ingredient: ingredient.text ?? "")
        if ingredient.text != nil{
            print("IF EXECUTED")
            //delegate?.checkboxClicked(ingredient: ingredient.text!)
            
        }else{
            print("ERROR. Ingredient.text is nil in ingredientHeader")
        }
    }
    
    
    func populateItemName(item: String, checked: Bool){
        if checked == true{
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item)
                     attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            ingredient.attributedText = attributeString
        }else{
            ingredient.text = item
        }
    }
    
}
