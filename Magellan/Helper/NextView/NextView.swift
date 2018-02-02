//
//  NextView.swift
//  Magellan
//
//  Created by Abide on 1/22/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit

class GotoNextView { // Start...
    
    static func showView(_ inViewController: UIViewController, StoryboardName: String, IdentifierName: String ) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: StoryboardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: IdentifierName)
        inViewController.present(nextViewController, animated:true, completion:nil)
    }
} // Close...

