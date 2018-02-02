//
//  ExploreCategoryViewController.swift
//  Magellan
//
//  Created by Ashish Jain on 09/12/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class ExploreCategoryViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var exploreListModel: ExploreListModel?
    var exploreLanderModel: ExploreLanderModel?
    var index: Int = 0
    var commonCellHeight = 0.0
    var commonCellWidth = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerTableViewCell()
        getCommonCellSizeHeight()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectCategoryAction(_ sender: Any) {
        if let exploreCategoryPickerVC = ExploreCategoryPickerViewController.instantiate(fromAppStoryboard: .explore) {
            exploreCategoryPickerVC.delegate = self
            exploreCategoryPickerVC.categoryDataSource = exploreListModel?.exploreList.map {
                return $0.title ?? ""
            }
            exploreCategoryPickerVC.selectIndexpath = index
            present(exploreCategoryPickerVC, animated: true, completion: {
                exploreCategoryPickerVC.pickerView.selectRow(self.index, inComponent: 0, animated: true)
            })
        }
    }

    func registerTableViewCell() {
        tableView.register(UINib(nibName : "CommonTableSectionHeaderCell", bundle: nil), forCellReuseIdentifier: "CommonTableSectionHeaderCell")
        tableView.register(UINib(nibName : "FeaturedCommonTableViewCell", bundle: nil), forCellReuseIdentifier: "FeaturedCommonTableViewCell")
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        tableView.estimatedSectionHeaderHeight = 25;
    }

    func getCommonCellSizeHeight(){
        //        commonCellWidth = Double(self.view.bounds.width * (375/232))
        //        commonCellHeight = commonCellWidth * (150/232)
        let width = Double(self.view.bounds.width)
        commonCellHeight = width * (150/width)
    }

    private func fetchExploreSubCategoryScreenData() {

        RequestManager().fetchExploreSubCategoryData(exploreId: (exploreLanderModel?.exploreId)!, index: (exploreLanderModel?.subLanderList.count)!, count: 10) { (status, responseModel, error) in
            if status, let exploreListModel = responseModel as? ExploreListModel {
                self.exploreLanderModel?.subLanderList = exploreListModel.exploreList
                self.tableView.reloadData()
            }
        }

    }

    fileprivate func setupView() {
        categoryLabel.text = exploreListModel?.exploreList[index].title
        exploreLanderModel = exploreListModel?.exploreList[index]
        fetchExploreSubCategoryScreenData()
    }
}

extension ExploreCategoryViewController : UITableViewDelegate, UITableViewDataSource, FeaturedCommonTableViewCellDelegate, ExploreCategoryPickerViewControllerProtocol {

    func numberOfSections(in tableView: UITableView) -> Int {
        return exploreLanderModel?.subLanderList.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(commonCellHeight)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonTableSectionHeaderCell" ) as!  CommonTableSectionHeaderCell
        cell.headerLabel.text = exploreLanderModel?.subLanderList[section].title
        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedCommonTableViewCell" ) as!  FeaturedCommonTableViewCell
        cell.selectionStyle = .none
        cell.delegateObj = self
        cell.exploreLanderModel = exploreLanderModel?.subLanderList[indexPath.section]
        cell.loadCollectionView()
        return cell
    }

    func didTapOnCell(model: Any) {
        let model = model as! ContentModel
        if let vc = VideoViewController.instantiate(fromAppStoryboard: .video) {
            vc.model = model
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func didSelectCategory(selectedRow: Int) {
        index = selectedRow
        setupView()
    }
}

