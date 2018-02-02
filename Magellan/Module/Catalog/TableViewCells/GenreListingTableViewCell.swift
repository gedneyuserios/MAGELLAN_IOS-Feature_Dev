//
//  GenreListingTableViewCell.swift
//  Magellan
//
//  Created by Ashish Jain on 07/01/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit

class GenreListingTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(contentModel: ContentModel?) {
        if let contentModelObj = contentModel {
            mainImageView.sd_setImage(with: URL(string: contentModelObj.imageUrl!), placeholderImage: UIImage(named: "logoMagellanHero"))
            durationLabel.text = contentModelObj.duration != "" ? contentModelObj.duration : "\(String(describing: contentModelObj.episodesCount!)) EPISODES"
            progressView.isHidden = contentModelObj.episodesCount != -1
        }
    }

}
