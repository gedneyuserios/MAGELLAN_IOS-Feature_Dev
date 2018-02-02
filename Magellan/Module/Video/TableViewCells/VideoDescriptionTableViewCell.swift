//
//  VideoDescriptionTableViewCell.swift
//  Magellan
//
//  Created by Abide on 07/01/18.
//  Copyright © 2018 Abide. All rights reserved.
//

import UIKit
import Foundation


class VideoDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var videoTimeLabel: UILabel!
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    //My..
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    //let attributedString = NSMutableAttributedString()
    
    
    
    //My...
    
    @IBAction func rateButtonAction(_ sender: Any) { }
    
    @IBAction func watchListButtonAction(_ sender: Any) { }
   
    @IBAction func shareButtonAction(_ sender: Any) { }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: VideoModel){
        
        //videoTitleLabel.text?.capitalized
        videoTitleLabel.text = model.title.uppercased()
        //ratingLabel.text = model.rating > 0 ? String(model.rating) : "95% (1,988 ratings)"
        guard let ratingStr = String("\(String(describing: model.ratePercentage!))%"+" (\(model.ratingCount!) ratings)") else { return }
        
        ratingLabel.text = ratingStr
        
        videoDescriptionLabel.text = model.uniqueDescription
        videoTimeLabel.text = "\(model.duration) min"
        self.contentView.backgroundColor = UIColor.clear
        
        videoDescriptionLabel.text = "Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris."
        
        print("\n\n\n\n your rating \(model.rating)\n\n\n\n")
        
        let attributedString = NSMutableAttributedString(string: videoDescriptionLabel.text!, attributes: [
            NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14.0)!,
            NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 1.0),
            NSKernAttributeName: -0.37
            ])
 
          
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 4 // Whatever line spacing you want in points
        //paragraphStyle.lineHeightMultiple = -0.2
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
 
        // *** Set Attributed String to your label ***
        videoDescriptionLabel.attributedText = attributedString;
        
 
    }
    
}
