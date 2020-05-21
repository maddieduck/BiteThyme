//
//  SignUpViewController.swift
//  BiteThyme
//
//  Created by Maddie Drake on 5/19/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUp: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements(){
        error.alpha = 0

        Utilities.styleTextField(firstName)
        Utilities.styleTextField(lastName)
        Utilities.styleTextField(email)
        Utilities.styleTextField(password)
        Utilities.styleFilledButton(signUp)
    }
    
    //check the fields and validate that the data is correct.
    //Returns nil if everything correct.
    //Returns error if there is an error.
    func validateFields() -> String?{
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil 
    }

    @IBAction func signUpPressed(_ sender: Any) {

        //Validate Fields
        let error = validateFields()
        if error != nil{
            showErrorMessage(message: error!)
        }else{
            //create cleaned version of first and last name
            let firstNameCleaned = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastNameCleaned = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailCleaned = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordCleaned = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            //Create the user
            Auth.auth().createUser(withEmail: emailCleaned, password: passwordCleaned) { (result, err) in
                //check for errors
                if err != nil{
                    //There was an error creating the user
                    self.showErrorMessage(message: "Error creating user")
                }else{
                    //user was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "firstname": firstNameCleaned,
                        "lastname": lastNameCleaned,
                        "uid": result!.user.uid
                    ]) { (error) in
                        if error != nil{
                            print("User data could not be saved in the database.")
                        }
                    }
                    //Transition to the home screen
                    self.transitionToStartView()
                }
            }
        }
    }
    
    func showErrorMessage(message: String) {
        error.text = message
        error.alpha = 1
    }
    
    func transitionToStartView(){
        let startViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.groceryLists) as? GroceryLists
        view.window?.rootViewController = startViewController
        view.window?.makeKeyAndVisible()
    }

}
