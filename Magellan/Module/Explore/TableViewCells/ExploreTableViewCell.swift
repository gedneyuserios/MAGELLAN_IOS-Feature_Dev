//
//  ExploreTableViewCell.swift
//  Magellan
//
//  Created by Ashish Jain on 09/12/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit
import SDWebImage

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configureCell(explore: ExploreLanderModel) {
        titleLabel.text = explore.title?.uppercased()
        mainImageView.sd_setImage(with: URL(string: explore.detailImageUrl), placeholderImage: nil)
    }

}
