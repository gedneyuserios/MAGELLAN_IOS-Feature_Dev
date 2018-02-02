//
//  RateViewController.swift
//  Magellan
//
//  Created by Rahul on 1/27/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit
import QuartzCore

class RateViewController: UIViewController {
    
    var videoId = Int()
    var userId  = String()
    var itemType = String()
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    public func configureRateData(model: VideoModel){
        videoId = model.id!
        userId = "207" //TODO: Dynamic Value
        
        if(String(describing: model.productType).contains("series"))
        { itemType = "s" }
        else { itemType = "v" }
       
    }
    
    //Buttons Actions...
    @IBAction func likeAction(_ sender: Any) {
        
        if(likeButton.isSelected) {
            return
        } else {
        
            UIView.animate(withDuration: 1.0, animations: {
            self.changeButtonStyleWith(buttonName: self.likeButton, boolS: false, backGrdColor: UIColor.selectedGrey, borderColor: UIColor.clear, borderWitdh: 0.0)
            
            self.fetchRateData(rateIndex: 5, fromButton: self.likeButton)
         })
        }
    }
    
 
    @IBAction func disLikeAction(_ sender: Any) {
        
        if(dislikeButton.isSelected) {
            return
            
        } else {
            
            UIView.animate(withDuration: 1.0, animations: {
                self.changeButtonStyleWith(buttonName: self.dislikeButton, boolS: false, backGrdColor: UIColor.selectedGrey, borderColor: UIColor.clear, borderWitdh: 0.0)
                
                self.fetchRateData(rateIndex: 1, fromButton: self.dislikeButton)
            })
        }
    } 
    
    
    func setUpButtons() {
        //Like Button....1
        self.likeButton.tag = 5
        self.likeButton.layer.cornerRadius = self.likeButton.frame.size.width / 2
        self.likeButton.layer.masksToBounds = false
        self.likeButton.clipsToBounds = true
        //likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 100.0, 100.0)
        //self.likeButton.addTarget(self, action: #selector(callRateApiNowWithButtonIndex(sender:)), for: .touchUpInside)

        
        //Dislike Button....2
        self.dislikeButton.tag = 1
        self.dislikeButton.layer.cornerRadius = self.dislikeButton.frame.size.width / 2
        self.dislikeButton.layer.masksToBounds = false
        self.dislikeButton.clipsToBounds = true
        
        //self.dislikeButton.addTarget(self, action: #selector(callRateApiNowWithButtonIndex(sender:)), for: .touchUpInside)
               
    }
    
    func fetchRateData(rateIndex: Int,fromButton: UIButton) {
        
        //Params = rating: '1',  userId: '213', item_type: 'v', videoId: 'videoId'
        let parameters: [String: AnyObject] = [ "rating": "\(rateIndex)" as AnyObject,
                                                "userId": userId as AnyObject,
                                                "item_type": itemType as AnyObject,
                                                "videoId": videoId as AnyObject
        ]
        
        RequestManager().fetchRateApi(paramS: parameters, responseBlock: { (status, responseModel, error) -> Void in
            
            if status, let rateModel = responseModel as? RateModel {
                
                if(rateModel.responseCode == 403) {
                   
                    UIView.animate(withDuration: 0.5, animations: {
                        self.changeButtonStyleWith(buttonName: fromButton, boolS: true, backGrdColor: UIColor.white, borderColor: UIColor.brightLightBlue, borderWitdh: 3.0)
                    })
                    
                    self.likeButton.isUserInteractionEnabled = false
                    self.dislikeButton.isUserInteractionEnabled = false
                }
                
                if(rateModel.responseCode == 200) {
                    self.likeButton.isUserInteractionEnabled = false
                    self.dislikeButton.isUserInteractionEnabled = false
                }
                
            } else { print(NSError())} })
    }
    
    
    //Back...
    @IBAction func backActionRateView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Others....
    func changeButtonStyleWith(buttonName:UIButton,boolS:Bool,backGrdColor:UIColor,borderColor:UIColor,borderWitdh:CGFloat) {
        
        buttonName.isSelected = boolS
        buttonName.backgroundColor = backGrdColor
        buttonName.borderColor = borderColor
        buttonName.borderWidth = borderWitdh
    }
    
}
