//
//  Login.swift
//  BiteThyme
//
//  Created by Maddie Drake on 5/19/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit

class Login: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()

    }
    
    func setupElements(){
        Utilities.styleTextField(email)
        Utilities.styleTextField(password)
        Utilities.styleFilledButton(login)
        error.alpha = 0
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
    }
    

}
