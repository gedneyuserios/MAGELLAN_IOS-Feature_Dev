//
//  GenresListingViewController.swift
//  Magellan
//
//  Created by Ashish Jain on 07/01/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class GenresListingViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var genreModel: GenreModel?
    var itemInfo = IndicatorInfo(title: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        fetchGenreData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView DataSource and Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreModel?.contentList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreListingTableViewCell" ) as!  GenreListingTableViewCell
        cell.selectionStyle = .none
        cell.configureCell(contentModel: genreModel?.contentList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = genreModel?.contentList[indexPath.row]
        if let vc = VideoViewController.instantiate(fromAppStoryboard: .video) {
            vc.model = model
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - API Calls
    func fetchGenreData(){
        if let genreId = genreModel?.genresId, let index = genreModel?.contentList.count {
            RequestManager().fetchGenreData(genreId: genreId, index: index, count: 10) { (status, responseModel, error) in
                if status, let genreModel = responseModel as? GenreModel {
                    self.genreModel?.contentList.append(contentsOf: genreModel.contentList)
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
