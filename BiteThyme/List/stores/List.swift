//
//  List.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/27/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit

//Kroger
let callbackName = Notification.Name(rawValue: KrogerCallbackNotifier)
let KrogerCallbackNotifier = "KrogerCallbackNotifier"


class List: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ArrayOfItems = ["milk", "eggs", "cheese"]
    
    @IBOutlet weak var ListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: callbackName, object: nil, queue: nil) { (Notification) in
            //Kroger has given an Auth key and now we have to get the access token
            print("OBSERVER ", Notification.object)
            self.dismiss(animated: true)
            if Notification.object != nil{
                self.getAccessToken(authType: .authorization_code, scope: .productCompact, authKey: Notification.object as! String)
            }
        }
        
        //print("header encoded ", headerEncoded)
        
        Authorization()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //ArrayOfItems.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ArrayOfItems[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ArrayOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListTableView.dequeueReusableCell(withIdentifier: "ListTableViewCellID", for: indexPath) as! ListTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
