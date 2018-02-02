//
//  FeaturedLargeTableViewCells.swift
//  Magellan
//
//  Created by Deepak on 28/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

protocol FeaturedLargeTableViewCellProtocol: class {
    func cellDidScroll(indexPath: IndexPath)
}

class FeaturedLargeTableViewCells: UITableViewCell {

    var featureModel : FeaturedModel?
    weak var delegate: FeaturedLargeTableViewCellProtocol?
    var vc : ViewController?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        registerNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        pageControl.numberOfPages = featureModel?.contentList.count ?? 0
    }
    
    func registerNib(){
        collectionView.register(UINib(nibName : "FeaturedLargeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedLargeCollectionViewCell")
    }
}

extension FeaturedLargeTableViewCells : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (featureModel?.contentList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedLargeCollectionViewCell", for: indexPath) as! FeaturedLargeCollectionViewCell
        cell.configureUI(model: (featureModel?.contentList[indexPath.item])!)
        return cell
    }
    
    
    func collectionView(_ collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:IndexPath) -> CGSize{
        return CGSize.init(width: self.bounds.width, height: self.bounds.height - 15)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = collectionView.indexPathsForVisibleItems.first {
            pageControl.currentPage = indexPath.row
            delegate?.cellDidScroll(indexPath: indexPath)
        }
    }
    
    
}

