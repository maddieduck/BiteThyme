//
//  AddIngreient.swift
//  BiteThyme
//
//  Created by Maddie Drake on 5/25/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit

class AddIngredient: UITableViewCell {

    @IBOutlet weak var addItemTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        print("click click")
    }
    
}
