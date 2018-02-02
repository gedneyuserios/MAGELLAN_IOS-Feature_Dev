//
//  VideoViewController.swift
//  Magellan
//
//  Created by Deepak on 07/01/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit
import Social

class VideoViewController: UIViewController {
    
    var model : ContentModel?
    var videoModel : VideoModel?
    //var featuredList = [FeaturedModel]()
    
    var videoIdString = String()
    
    @IBOutlet weak var playerBackgroundView: UIImageView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var videoTableView: UITableView!
    
    var sectionArray = [SectionType]()
    
    //My...
    var typeString = String()
    
    //My...
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.videoTableView.isHidden = true
        self.playerBackgroundView.isHidden = true
        self.playerView.isHidden = true
        
        registerNib()
        fetchVideoData()
        
    }
    
  
 
    @IBAction func backAction(_ sender: Any) {
        //navigationController?.popViewController(animated: true)
        
        if FeaturedViewController.instantiate(fromAppStoryboard: .feature) != nil {
            navigationController?.popViewController(animated: true)
            
        } 
        if WatchListViewController.instantiate(fromAppStoryboard: .watchList) != nil {
            
            //self.dismiss(animated: true, completion: nil)
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        }
         
    } 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchVideoData(){
        
        if model?.productType == ProductType.video{
            if let id = model?.id{
                let str = String(describing: id)
                videoIdString = "video/\(str)"

            }
        }else if model?.productType == ProductType.series{
            if let id = model?.id{
            let str = String(describing: id)
            videoIdString = "series/\(str)"
            
            }
        }
        
        fetchVideoDataWith(Id: videoIdString)
        
    }
    
    func configureImage(){
        playerBackgroundView.sd_setImage(with: URL(string: (videoModel?.imageUrl)!), placeholderImage: nil)
    }


    func setTableSection(model : VideoModel){
        sectionArray.removeAll()
        
        sectionArray.append(SectionType.video)
        
        if model.episodeModelArray.count > 0{
            sectionArray.append(SectionType.episode)
        }
        if model.relatedContentArray.count > 0{
            sectionArray.append(SectionType.related)
        }
    }
    
    func loadTableView(){
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.reloadData()
    }
    
    func registerNib(){
        videoTableView.register(UINib(nibName : "TableHeaderCell", bundle: nil), forCellReuseIdentifier: "TableHeaderCell")
        videoTableView.register(UINib(nibName : "VideoDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoDescriptionTableViewCell")
        videoTableView.register(UINib(nibName : "EpisodeVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeVideoTableViewCell")
        videoTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        videoTableView.estimatedSectionHeaderHeight = 25;
        videoTableView.estimatedRowHeight = 100
        videoTableView.rowHeight = UITableViewAutomaticDimension
    }
} 

extension VideoViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return sectionArray.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let type = sectionArray[section]
        
        switch type {
        case .video:
            return 1
        case .episode:
            return videoModel?.episodeModelArray.count ?? 0
        case .related:
            return videoModel?.relatedContentArray.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableViewAutomaticDimension
        }else{
            return 80.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = videoTableView.dequeueReusableCell(withIdentifier: "EpisodeVideoTableViewCell" ) as!  EpisodeVideoTableViewCell
        
        let type = sectionArray[indexPath.section]

        switch type {
        case .video:
            let cell = videoTableView.dequeueReusableCell(withIdentifier: "VideoDescriptionTableViewCell" ) as!  VideoDescriptionTableViewCell
            cell.configureCell(model: videoModel!)
            
            //My..
            cell.shareButton.addTarget(self, action: #selector(shareButtonAction(sender:)), for: .touchUpInside)
            cell.watchListButton.addTarget(self, action: #selector(callwatchListAction(sender:)), for: .touchUpInside)
            cell.rateButton.addTarget(self, action: #selector(callRateAction(sender:)), for: .touchUpInside)
            
            cell.backgroundColor = UIColor.clear
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            //My...
            
            return cell
        case .episode:
            tableCell.configureCellForEpisodeContent(model : (videoModel?.episodeModelArray[indexPath.row])!)
            return tableCell
        case .related:
            tableCell.configureCellForRelatedContent(model : (videoModel?.relatedContentArray[indexPath.row])!)
            
            return tableCell
        }
    }
    
    //My..share
    @objc func callRateAction(sender: UIButton){
       
        let myVC = storyboard?.instantiateViewController(withIdentifier: "RateViewController") as! RateViewController
        myVC.configureRateData(model: videoModel!)
        
        self.present(myVC, animated:true, completion:nil)

       //GotoNextView.showView(self, StoryboardName: "Video", IdentifierName: "RateViewController")
        
    }
    
    @objc func callwatchListAction(sender: UIButton){
        
        GotoNextView.showView(self, StoryboardName: "WatchList", IdentifierName: "WatchListViewController")
    }
     
    
    func presentShareViewWith(model: VideoModel){
        
        //1
        let shareTitle = ("\(model.title)")
        
        //2
        let shareImage = UIImageView()
        shareImage.sd_setImage(with: URL(string: model.imageUrl), placeholderImage:nil)
        
        //3
        let shareDescription = ("\(model.uniqueDescription)\n)")
        
        // set up activity view controller
        //let textToShare = [shareDescription, shareImage.image ?? "Image", shareTitle] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: [shareTitle,shareDescription], applicationActivities: nil)
         
        activityViewController.setValue(shareTitle, forKey: "Subject")
        
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
       
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    //Action..
    @objc func shareButtonAction(sender: UIButton){
        //showLoader()
        let buttonTag = sender.tag
        print("Share Button Tapped \(buttonTag)")
        
        presentShareViewWith(model: videoModel!)
        
    }
    
    
    //My...shareEnd
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = videoTableView.dequeueReusableCell(withIdentifier: "TableHeaderCell" ) as!  TableHeaderCell
        let type = sectionArray[section]
 
        switch type {
        case .video:
            return UIView()
        case .episode:

            if let count  = videoModel?.episodeModelArray.count{
                
                let attributedString = NSMutableAttributedString(string: "EPISODES \(String(describing: count))", attributes: [
                    NSFontAttributeName: UIFont(name: "SemplicitaPro-Bold", size: 17.0)!,
                    NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 1.0),
                    NSKernAttributeName: -1.0
                    ])
                attributedString.addAttribute(NSKernAttributeName, value: -0.1, range: NSRange(location: 0, length: 4))
                
                cell.headerLabel.attributedText = attributedString
                
                //cell.headerLabel.text = "EPISODES \(String(describing: count))"
            }

            return cell
        case .related:

            if let count  = videoModel?.relatedContentArray.count{
                //cell.headerLabel.text = "RELATED CONTENT \(String(describing: count))"
                print(count)
                //My
                let attributedString = NSMutableAttributedString(string: "RELATED CONTENT", attributes: [
                    NSFontAttributeName: UIFont(name: "SemplicitaPro-Bold", size: 15.0)!,
                    NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 1.0),
                    NSKernAttributeName: -0.1
                    ])
                attributedString.addAttribute(NSKernAttributeName, value: -0.1, range: NSRange(location: 0, length: 4))
 
                cell.headerLabel.attributedText = attributedString
                
                //cell.backgroundView = self.TableHeaderGradientView
                
                //cell.addSubview(self.TableHeaderGradientView)
                
                //cell.backgroundColor = UIColor.clear
     
            }
            
            self.videoTableView.isHidden = false
            self.playerBackgroundView.isHidden = false
            self.playerView.isHidden = false
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return UITableViewAutomaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let indexP = tableView.indexPathForSelectedRow
        if let cell = videoTableView.cellForRow(at: indexP!) as? EpisodeVideoTableViewCell {
        
           fetchVideoDataWith(Id: cell.stringId)
        }
       
    }
    
    
    func fetchVideoDataWith(Id: String) {
        RequestManager().fetchVideoData(videoId : Id, responseBlock: { (status, responseModel, error) -> Void in
            if status, let videoModel = responseModel as? VideoModel {
                self.videoModel = videoModel
                self.setTableSection(model: videoModel)
                self.loadTableView()
                //self.loadPlayer()
                self.configureImage()
            }
        })
    }
    
}

extension VideoViewController : JWPlayerDelegate{
    func loadPlayer(){
        print (videoModel?.jwpVideoUrl ?? "")
        var player = JWPlayerController()
        let config: JWConfig = JWConfig()
//        let url = URL.init(string: "https://www.rmp-streaming.com/media/bbb-360p.mp4")
//        config.sources = [JWSource(file: "https://www.rmp-streaming.com/media/bbb-360p.mp4", label: "720p Streaming", isDefault: true)]
        config.file = "https://www.rmp-streaming.com/media/bbb-360p.mp4"
        config.controls = true
        config.repeat = false;
        config.premiumSkin = JWPremiumSkinRoundster
        player = JWPlayerController(config:config)
        player.view.frame = playerView.frame
        playerView.addSubview(player.view)
        player.delegate = self
        
        player.play()
    }
    
    func onPlayAttempt() {
        print ("onPlay")
    }
    
    func onBeforePlay() {
        print ("onBeforePlay")
    }
    
    func onPlay(_ oldState: String!) {
        print ("oldState")
    }
    
    func onPlay() {
        print ("oldState")

    }
    
}
