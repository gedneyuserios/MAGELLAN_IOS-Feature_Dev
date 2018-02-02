//
//  FeaturedCommonTableViewCell.swift
//  Magellan
//
//  Created by Deepak on 23/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

protocol FeaturedCommonTableViewCellDelegate {
    func didTapOnCell (model : Any)
}

class FeaturedCommonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var commonCellWidth = 0.0
    var commonCellHeight = 0.0
    var featureModel : FeaturedModel?
    var exploreLanderModel : ExploreLanderModel?
    var delegateObj : FeaturedCommonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getCommonCellSizeHeight()
        registerNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadCollectionView(){
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    func getCommonCellSizeHeight(){
        commonCellWidth = Double(self.bounds.width * (232/375))
        commonCellHeight = commonCellWidth * (150/232)
    }
    
    func registerNib(){
        collectionView.register(UINib(nibName : "FeaturedCommonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCommonCollectionViewCell")
    }
    
}


extension FeaturedCommonTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let featModel = featureModel {
            return featModel.contentList.count
        } else if let expModel = exploreLanderModel {
            return expModel.contentList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCommonCollectionViewCell", for: indexPath) as! FeaturedCommonCollectionViewCell
        if let featModel = featureModel {
            cell.configureUI(model: featModel.contentList[indexPath.item])
        } else if let expModel = exploreLanderModel {
            cell.configureUI(model: expModel.contentList[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:IndexPath) -> CGSize{
        return CGSize.init(width: commonCellWidth, height: commonCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let feature = featureModel{
            let model = feature.contentList[indexPath.item] as Any
            delegateObj?.didTapOnCell(model: model)
        }else if let explore = exploreLanderModel{
            let model = explore.contentList[indexPath.item] as Any
            delegateObj?.didTapOnCell(model: model)
        }else{
            return
        }
    }

    
}
