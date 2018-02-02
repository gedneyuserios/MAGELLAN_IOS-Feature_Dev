//
//  CommonTableSectionHeaderCell.swift
//  Magellan
//
//  Created by Deepak on 28/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class CommonTableSectionHeaderCell: UITableViewCell {

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
