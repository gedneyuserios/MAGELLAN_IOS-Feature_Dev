//
//  FeaturedViewController.swift
//  Magellan
//
//  Created by Deepak on 23/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var featureTableView: UITableView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    var featuredList = [FeaturedModel]()
    var largerCellWidth = 0.0
    var largerCellHeight = 0.0
    var commonCellHeight = 0.0
    var commonCellWidth = 0.0
    
    //my
    var resizeUrl = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        featureTableView.isHidden = true

        fetchHomeScreenData()
        registerTableViewCell()
        getLargeCellHeight()
        getCommonCellSizeHeight()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getLargeCellHeight(){
//        largerCellWidth = Double(self.view.bounds.width * (375/232))
//        largerCellHeight = largerCellWidth * (150/232)
        largerCellHeight = Double(self.view.bounds.height - 190)
    }
    
    func getCommonCellSizeHeight(){
//        commonCellWidth = Double(self.view.bounds.width * (375/232))
//        commonCellHeight = commonCellWidth * (150/232)
        let width = Double(self.view.bounds.width)
        commonCellHeight = width * (150/width)
    }
    
    
    func registerTableViewCell() {
        featureTableView.register(UINib(nibName : "CommonTableSectionHeaderCell", bundle: nil), forCellReuseIdentifier: "CommonTableSectionHeaderCell")
        featureTableView.register(UINib(nibName : "FeaturedLargeTableViewCells", bundle: nil), forCellReuseIdentifier: "FeaturedLargeTableViewCells")
        featureTableView.register(UINib(nibName : "FeaturedCommonTableViewCell", bundle: nil), forCellReuseIdentifier: "FeaturedCommonTableViewCell")
        self.featureTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        self.featureTableView.estimatedSectionHeaderHeight = 25;

    }
    
    func loadTableView(){
        featureTableView.dataSource = self
        featureTableView.delegate = self
        featureTableView.isHidden = false
        featureTableView.reloadData()
    }
    
    func fetchHomeScreenData(){
        RequestManager().fetchHomeScreenData(responseBlock: { (status, responseModel, error) -> Void in
            if status, let featuredListModel = responseModel as? FeaturedListModel {
                
                self.featuredList = featuredListModel.featuredList
                
                if (UIDevice.current.userInterfaceIdiom == .phone) {
                 
                    if(UIScreen.main.scale == 1.0) {
                        self.resizeUrl = self.featuredList[0].contentList[0].imagePath!+self.featuredList[0].contentList[0].resizedmobileImage!+"1x-375*627.png"
                        
                    }
                    
                    if(UIScreen.main.scale == 2.0) {
                        self.resizeUrl = self.featuredList[0].contentList[0].imagePath!+self.featuredList[0].contentList[0].resizedmobileImage!+"2x-750*1254.png"
                     
                    }
                    
                    if(UIScreen.main.scale == 3.0) {
                        self.resizeUrl = self.featuredList[0].contentList[0].imagePath!+self.featuredList[0].contentList[0].resizedmobileImage!+"3x-1125*1881.png"
                       
                    }
                    
              }
                
                if (UIDevice.current.userInterfaceIdiom == .pad) {
                    
                    if(UIScreen.main.scale == 1.0) {
                        self.resizeUrl = self.featuredList[0].contentList[0].imagePath!+self.featuredList[0].contentList[0].resizedImage!+"1x-1024*748.png"
                        
                    }
                    
                    if(UIScreen.main.scale == 2.0) {
                        self.resizeUrl = self.featuredList[0].contentList[0].imagePath!+self.featuredList[0].contentList[0].resizedImage!+"2x-2048*1496.png"
                        
                    }
                    
                    if(UIScreen.main.scale == 3.0) {
                        self.resizeUrl = self.featuredList[0].contentList[0].imagePath!+self.featuredList[0].contentList[0].resizedImage!+"3x-3072*2244.png"
                        
                    }
                }
                
                print("\n\n\n\n\n\n\n", self.resizeUrl,"\n\n\n\n\n")
                
                self.backgroundImageView.sd_setImage(with: URL(string:self.resizeUrl), placeholderImage: nil)
                self.loadTableView()
            }
            
        })
    }

    func cellDidScroll(indexPath: IndexPath) {
        //featuredList[indexPath.section].contentList[indexPath.row].imageUrl! // Don't
        var urlString = String()
        
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            
            if(UIScreen.main.scale == 1.0) {
                
                urlString = self.featuredList[indexPath.section].contentList[indexPath.row].imagePath!+self.featuredList[indexPath.section].contentList[indexPath.row].resizedmobileImage!+"1x-375*627.png"
                
            }
            
            if(UIScreen.main.scale == 2.0) {
                
                
                urlString = self.featuredList[indexPath.section].contentList[indexPath.row].imagePath!+self.featuredList[indexPath.section].contentList[indexPath.row].resizedmobileImage!+"2x-750*1254.png"
                
            }
            
            if(UIScreen.main.scale == 3.0) {
               
                urlString = self.featuredList[indexPath.section].contentList[indexPath.row].imagePath!+self.featuredList[indexPath.section].contentList[indexPath.row].resizedmobileImage!+"3x-1125*1881.png"
                
            }
            
        }
        
        DispatchQueue.main.async {
        
        self.backgroundImageView.sd_setImage(with: URL(string:urlString), placeholderImage: nil)
            
        }
 
        print("\n\n\n\n\n\n\n", urlString,"\n\n\n\n\n")
         
       // backgroundImageView.sd_setImage(with: URL(string:featuredList[indexPath.section].contentList[indexPath.row].imageUrl!), placeholderImage: nil)
        
    }
}

extension FeaturedViewController : UITableViewDelegate, UITableViewDataSource, FeaturedLargeTableViewCellProtocol, FeaturedCommonTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return featuredList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(largerCellHeight)
        }else{
            return CGFloat(commonCellHeight)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }
        let cell = featureTableView.dequeueReusableCell(withIdentifier: "CommonTableSectionHeaderCell" ) as!  CommonTableSectionHeaderCell
        cell.headerLabel.text = featuredList[section].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = featureTableView.dequeueReusableCell(withIdentifier: "FeaturedLargeTableViewCells" ) as!  FeaturedLargeTableViewCells
            cell.selectionStyle = .none
            cell.featureModel = featuredList[indexPath.section]
            cell.loadCollectionView()
            cell.delegate = self
            return cell
        }
        
        let cell = featureTableView.dequeueReusableCell(withIdentifier: "FeaturedCommonTableViewCell" ) as!  FeaturedCommonTableViewCell
        cell.selectionStyle = .none
        cell.delegateObj = self
        cell.featureModel = featuredList[indexPath.section]
        cell.loadCollectionView()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let blurValue = featureTableView.contentOffset.y/(featureTableView.contentSize.height-featureTableView.frame.height)
        blurView.alpha = blurValue
        if let cell = featureTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? FeaturedLargeTableViewCells {
            if blurValue > 0 {
                cell.pageControl.alpha = 1 - blurValue
            }
        }
    }
     
    func didTapOnCell(model: Any) {
        let model = model as! ContentModel
        if let vc = VideoViewController.instantiate(fromAppStoryboard: .video) {
            vc.model = model
            navigationController?.pushViewController(vc, animated: true) //here...
            
        }
    }
}
