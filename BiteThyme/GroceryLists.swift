//
//  GroceryLists.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/26/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit

class GroceryLists: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var listsArray = ["List Number 1 ", "List Number Two", "Threee", "Fourrrr", "Five"]
    
    @IBOutlet weak var groceryListsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groceryListsTableView.dataSource = self
        groceryListsTableView.delegate = self
        groceryListsTableView.register(UINib(nibName: "GroceryListsCell", bundle: nil), forCellReuseIdentifier: "GroceryListsCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groceryListsTableView.dequeueReusableCell(withIdentifier: "GroceryListsCell") as! GroceryListsCell
        cell.listName.text = listsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToList", sender: listsArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToList"{
            let destination = segue.destination as! List
            destination.listTitle = sender as! String
        }
        
    }

}
