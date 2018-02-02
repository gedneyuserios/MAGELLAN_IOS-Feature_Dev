//
//  ExploreViewController.swift
//  Magellan
//
//  Created by Ashish Jain on 09/12/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var exploreListModel: ExploreListModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchExploreScreenData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func fetchExploreScreenData() {
        RequestManager().fetchExploreData(responseBlock: { (status, responseModel, error) -> Void in
            if status, let exploreListModel = responseModel as? ExploreListModel {
                self.exploreListModel = exploreListModel
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        })
    }
}

extension ExploreViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreListModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell" ) as!  ExploreTableViewCell
        cell.selectionStyle = .none
        cell.configureCell(explore: (exploreListModel?.exploreList[indexPath.row])!)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let exploreCategoryVC = ExploreCategoryViewController.instantiate(fromAppStoryboard: .explore) {
            exploreCategoryVC.exploreListModel = exploreListModel
            exploreCategoryVC.index = indexPath.row
            exploreCategoryVC.exploreLanderModel = exploreListModel?.exploreList[indexPath.row]
            navigationController?.pushViewController(exploreCategoryVC, animated: true)
        }
    }
}
