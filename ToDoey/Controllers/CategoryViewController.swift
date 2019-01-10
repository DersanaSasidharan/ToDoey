//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Dersana on 07/01/19.
//  Copyright © 2019 Dersana. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    var categoryArray: Results<Category>?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        loadCategories()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")!
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No category added"
        return cell
    }
    
    //MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new category", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            do {
                try self.realm.write{
                    self.realm.add(newCategory)
                }
            }catch{
                print("Error saving category: \(error)")
            }
            self.loadCategories()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category Name"
            textField = alertTextField
        }
        alert.addAction(alertAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func loadCategories(){
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    

}
