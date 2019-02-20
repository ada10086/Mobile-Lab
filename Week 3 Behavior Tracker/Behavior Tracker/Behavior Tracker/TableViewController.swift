//
//  TableViewController.swift
//  Behavior Tracker
//
//  Created by Chuchu Jiang on 2/19/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TableViewCell"

private let mealsKey = "MEALS_KEY"


// Data element for table row.
// Note the "Codable" protocal
struct Meal: Codable {
    let imageName: String
    let date: String
    let bld: String
    let type: String
}


class TableViewController: UITableViewController {
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Data from user defaults and set data array.
        if let data = UserDefaults.standard.value(forKey: mealsKey) as? Data {
            
            let meals = try? PropertyListDecoder().decode(Array<Meal>.self, from: data)
            
            self.meals = meals!
            
            self.tableView.reloadData()
        }
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @IBAction func handleAddButton(_ sender: UIBarButtonItem) {
        // Instantiate View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ActionViewController") as? ActionViewController else {
            print("Error instantiating ActionViewController" )
            return
        }
        
        // Define callback method.
        vc.didSaveMeal = { [weak self] meal in
            
            self?.meals.append(meal)
            
            // Resave element array into User defaults.
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self?.meals), forKey: mealsKey)
            
            self?.tableView.reloadData()
        }
        
        // Present view controller.
        present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count    //number of items in array
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        
        let meal = meals[indexPath.row]

        cell.mealImage.image = UIImage(named: meal.imageName)
        cell.dateLabel.text = meal.date
        cell.mealLabel.text = meal.bld
        cell.typeLabel.text = meal.type
        
//        cell.dateLabel.text = element.date
//        cell.messageLabel.text = element.message
        
        //        if(indexPath.row % 2 ) == 0 {
        //            cell.backgroundColor = .gray
        //            //cell.myLabel.text = "Hello"
        //        }
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
