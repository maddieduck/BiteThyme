//
//  ingredientHeader.swift
//  
//
//  Created by Maddie Drake on 5/25/20.
//

import UIKit

class ingredientHeader: UITableViewCell {

    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var ingredient: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkboxPressed(_ sender: Any) {
        
    }
    
}
