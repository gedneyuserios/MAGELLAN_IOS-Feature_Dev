//
//  TableHeaderCell.swift
//  Magellan
//
//  Created by Rahul on 1/29/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit

class TableHeaderCell: UITableViewCell {
     
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
     
}

