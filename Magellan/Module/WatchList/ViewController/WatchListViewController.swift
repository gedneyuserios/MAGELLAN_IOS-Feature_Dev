//
//  WatchListViewController.swift
//  Magellan
//
//  Created by Abide on 1/25/18.
//  Copyright © 2018 Abide. All rights reserved.
//

import UIKit

class WatchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Table Array..../
    var titleArray = [String]()
    var durationArray = [String]()
    var imageUrlArray = [String]()
    var shortDescriptionArray = [String]()
    var countArray = [String]()
    var idArray = [String]()
    
    
    //Objects...
    let cellReuseIdentifier = "WatchListCell"
    @IBOutlet var tableView: UITableView!
    
    
    //MVC
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWatchListData(withUserId: "207") //TODO: Put dynamic value...
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName : "WatchListCell", bundle: nil), forCellReuseIdentifier: "WatchListCell") 
    }
    
    
    //Table View Delegates.....................................................
    
    //1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    } 
    
    //2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WatchListCell = self.tableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier) as! WatchListCell
         
        //Init...
        
        cell.watchTitleLabel.text = titleArray[indexPath.row]
        cell.watchDurationlabel.text = durationArray[indexPath.row]
        cell.watchVideoImageView.sd_setImage(with: URL(string: imageUrlArray[indexPath.row]), placeholderImage:nil)
        cell.watchEpisodeNumberLabel.text = countArray[indexPath.row] 
        //set up Cell Action...
        //cell.cellArrowButton4.tag = indexPath.row
        //cell.cellArrowButton4.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        
        return cell
         
    }
    
    //3
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
    //4
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let videoString = idArray [indexPath.row]
        
        let mainStoryBoard = UIStoryboard(name: "Video", bundle: nil)
        let nextView = mainStoryBoard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
        
        nextView.videoIdString = videoString  //For Test===> "series/129"
        
        self.present(nextView, animated:true, completion:nil)
        
    }
    
    
    
    
    func fetchWatchListData(withUserId : String) {
        
        let jsonUrlString = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/v4/userprofile/\(withUserId)"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                
                let responseModel = try JSONDecoder().decode(WatchListModel.self, from: data)
            
                for names in (responseModel.responseData?.watchLater)! {
                    
                    //guard let duration = names.duration else { return }
                    
                    //For Series.....
                    
                    if((names.seriesId) != nil) {
                       
                        self.configureCellDataWith(title: names.title!, duration: "", imageUrl: names.imageUrl!, id: String(names.seriesId!), count: String("Ep. \(names.episodesCount!)"))
                         
                    }
                    
                    // For Video.......
                    if((names.videoId) != nil) {
                    
                     self.configureCellDataWith(title: names.title!, duration: names.duration!, imageUrl: names.imageUrl!, id: String(names.videoId!), count: "")
                        
                    }
                    
                    // For Playlist......
                    
                    if((names.playlistId) != nil) {
                        
                       self.configureCellDataWith(title: names.title!, duration: "", imageUrl: names.imageUrl!, id: String(names.playlistId!), count: String("Playlist \(names.playlistCount!)"))
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                   self.tableView.reloadData()
                }
                
            } catch let jsonErr {
                
                print("Error serializing json:", jsonErr)
                
            } }.resume()
    }
    
    

    
    //Others Methods....
    
    @IBAction func backActionWatchList(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Init.....
    func configureCellDataWith(title: String,duration: String,imageUrl: String,id: String, count: String) {
        self.titleArray.append(title)
        self.durationArray.append(duration)
        self.imageUrlArray.append(imageUrl)
        self.idArray.append(id)
        self.countArray.append(count)
    }
    
}




