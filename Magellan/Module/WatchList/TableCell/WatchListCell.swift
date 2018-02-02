//
//  WatchListCell.swift
//  Magellan
//
//  Created by Abide on 1/25/18.
//  Copyright © 2018 Abide. All rights reserved.
//

import UIKit

class WatchListCell: UITableViewCell {
    
    //Outlets and Objects....
    @IBOutlet weak var watchVideoImageView: UIImageView!
    @IBOutlet weak var watchEpisodeNumberLabel: UILabel!
    @IBOutlet weak var watchTitleLabel: UILabel!
    @IBOutlet weak var watchDurationlabel: UILabel!
    @IBOutlet weak var watchIdLabel: UILabel!
    var stringId = ""
    
    //Init...
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
