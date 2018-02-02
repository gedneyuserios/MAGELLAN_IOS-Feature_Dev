//
//  GenresViewController.swift
//  Magellan
//
//  Created by Ashish Jain on 07/01/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class GenresViewController: ButtonBarPagerTabStripViewController {

    var isReload = false
    var genreList = [GenreModel]()

    override func viewDidLoad() {
        settings.style.selectedBarBackgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarMinimumInteritemSpacing = 16

        super.viewDidLoad()
        buttonBarView.selectedBar.backgroundColor = UIColor(red: 52/255, green: 205/255, blue: 254/255, alpha: 1)
        buttonBarView.backgroundColor = UIColor.clear
        settings.style.buttonBarBackgroundColor = UIColor.clear
        settings.style.buttonBarItemBackgroundColor = UIColor.clear
        settings.style.buttonBarItemTitleColor = UIColor.white
        fetchGenreListData()
    }


    func fetchGenreListData(){
        RequestManager().fetchGenresList(responseBlock: { (status, responseModel, error) -> Void in
            if status, let genreListModel = responseModel as? GenreListModel {
                self.genreList = genreListModel.genreList
                self.reloadPagerTabStripView()
            }
        })
    }


    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {

        var vcArray = [GenresListingViewController]()
        if genreList.count > 0 {
            for genre in genreList {
                let vc = GenresListingViewController.instantiate(fromAppStoryboard: .catalog)
                vc?.genreModel = genre
                vc?.itemInfo.title = genre.title
                vcArray.append(vc!)
            }
        }
        return vcArray.count > 0 ? vcArray : [GenresListingViewController.instantiate(fromAppStoryboard: .catalog)!]

    }

    override func reloadPagerTabStripView() {
        isReload = true
        pagerBehaviour = .progressive(skipIntermediateViewControllers: true, elasticIndicatorLimit: true)
        super.reloadPagerTabStripView()
    }
}
