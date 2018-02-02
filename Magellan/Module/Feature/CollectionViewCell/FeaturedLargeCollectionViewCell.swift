//
//  FeaturedLargeCollectionViewCell.swift
//  Magellan
//
//  Created by Deepak on 23/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class FeaturedLargeCollectionViewCell: UICollectionViewCell {

    
    
    @IBAction func watchButtonAction(_ sender: Any) {
        
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
     
    func configureUI(model : ContentModel){
        titleLabel.text = model.title
        descriptionLabel.text = model.shortDescription
    }
 

}
