//
//  TableViewCell.swift
//  Behavior Tracker
//
//  Created by Chuchu Jiang on 2/19/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
