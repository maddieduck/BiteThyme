//
//  Initial.swift
//  BiteThyme
//
//  Created by Maddie Drake on 5/19/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit

class Initial: UIViewController {

    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(signUp)
        Utilities.styleHollowButton(login)
    }
    

}
