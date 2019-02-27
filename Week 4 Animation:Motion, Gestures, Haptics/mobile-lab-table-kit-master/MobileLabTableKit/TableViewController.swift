//
//  TableViewController.swift
//  MobileLabTableKit
//
//  Created by Nien Lam on 4/13/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//

import UIKit


private let reuseIdentifier = "TableViewCell"

class TableViewController: UITableViewController {

    // Data objects.
    // TODO: Use data structures.
    var objects = [
        ["Dogs", "A member of the genus Canis", ["dog-1.jpg", "dog-2.jpg", "dog-3.jpg"]],
        ["Cats", "A small furry mammal", ["cat-1.jpg", "cat-2.jpg", "cat-3.jpg"]],
        ["Fish", "Animals that lack limbs with digits", ["fish-1.jpg", "fish-2.jpg", "fish-3.jpg"]],
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the row data count.
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get custom cell object.
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        
        // Get data object for selected row.
        let object = objects[indexPath.row]
        
        // Configure cell properties.
        cell.titleLabel.text         = object[0] as? String
        cell.detailLabel.text        = object[1] as? String

        // ... Use first image for thumbnail.
        let filename = (object[2] as! [String])[0]
        cell.thumbnailImageView.image = UIImage(named: filename)
        
        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get selected row index.
        guard let selectedRow = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        print("Selected Table Row: \(selectedRow)")
        
        // Get destination view controller
        let vc = segue.destination as! CollectionViewController

        // Pass data to destination view controller based on selected row.
        vc.objects = self.objects[selectedRow][2] as! Array
    }
}
