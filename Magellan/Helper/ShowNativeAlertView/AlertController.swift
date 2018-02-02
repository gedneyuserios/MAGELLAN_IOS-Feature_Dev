//
//  AlertController.swift
//
//  Created by Abide on 20/1/18.
//  Copyright © 2017 Abide All rights reserved.
// 

import UIKit

class AlertController {
    
    // Normal Alert View...
    
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
   
} // Close...


///   ...................................END OF Class.......................................///

