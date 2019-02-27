//
//  TableViewCell.swift
//  MobileLabTableKit
//
//  Created by Nien Lam on 4/13/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
