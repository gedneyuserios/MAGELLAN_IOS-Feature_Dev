//
//  FeaturedCommonCollectionViewCell.swift
//  Magellan
//
//  Created by Deepak on 23/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit
import SDWebImage

class FeaturedCommonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressView: GradientProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUI(model : ContentModel){
        imageView.sd_setImage(with: URL(string: model.imageUrl!), placeholderImage: nil)
        timeLabel.text = model.duration != "" ? model.duration : "\(String(describing: model.episodesCount!)) EPISODES"
        progressView.isHidden = model.episodesCount != -1
    }
     
}
