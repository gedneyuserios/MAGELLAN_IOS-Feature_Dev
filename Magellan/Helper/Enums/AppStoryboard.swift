//
//  AppStoryboard.swift
//  HDFC_Investor
//
//  Created by Ashish Jain on 15/05/17.
//  Copyright © 2017 TTN. All rights reserved.
//

import Foundation
import UIKit


enum ProductType {
    case video, series, explore, collection
}

enum SectionType {
    case video, episode, related
}

enum AppStoryboard: String {
    ////  If you are using the same storyboard name as the name of cases in enum, you can write the enum in a more concise manner. You can skip raw values as for string type enums, case name is the implicit raw value.
    case main = "Main"
    case feature = "Feature"
    case explore = "Explore"
    case login = "Login"
    case search = "Search"
    case catalog = "Catalog"
    case profile = "Profile"
    case video = "Video"
    case watchList = "WatchList"
     
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    /// T refers to the generic argument, T.Type means Data type of T.
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T? {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as? T
    }
}

extension UIViewController {
    //// Let’s assume one is using same name for class name and storyboard identifier.
    /// If one's using suffix "_ID" for storyboard identifier.
    /// "\(self)" can be replaced by "\(self)" + "_ID".
    class var storyboardID: String {
        return "\(self)"
        /// self will give right invoking classname
        /// other options could be
        /// return NSStringFromClass(type(of: self) as! AnyClass)
        /// return String(describing: self)
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self? {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
