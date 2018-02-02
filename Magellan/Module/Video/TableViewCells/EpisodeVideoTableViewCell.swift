//
//  EpisodeVideoTableViewCell.swift
//  Magellan
//
//  Created by Deepak on 07/01/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit

class EpisodeVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationlabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    var stringId = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configureCellForEpisodeContent(model : EpisodeListModel){
        videoImageView.sd_setImage(with: URL(string: model.imageUrl), placeholderImage: nil)
        episodeNumberLabel.text = String(describing: model.order!)
        titleLabel.text = model.title
        durationlabel.text = model.duration
        
        if let id = model.id{
            let str = String(describing: id)
            stringId = "video/\(str)"
        }
    }
    
    func configureCellForRelatedContent(model : RelatedModel){
        videoImageView.sd_setImage(with: URL(string: model.imageUrl), placeholderImage: nil)
        episodeNumberLabel.text = ""//String(model.episodesCount)
        titleLabel.text = model.title
        durationlabel.text = "121 min"
        
        if model.productType == ProductType.video{
            if let id = model.id{
                let str = String(describing: id)
                stringId = "video/\(str)"
    
            }
        }else if model.productType == ProductType.series{
            if let id = model.id{
                let str = String(describing: id)
                stringId = "series/\(str)"
            }
        }
        
    }
    
}

