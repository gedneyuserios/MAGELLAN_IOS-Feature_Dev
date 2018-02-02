//
//  ViewController.swift
//  Magellan
//
//  Created by Deepak on 21/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.hello
    
        label1.font = UIFont(name: appFontRegular, size: 35)
        label2.font = UIFont(name: appFontMedium, size: 35)
        label3.font = UIFont(name: appFontSemibold, size: 35)
        label4.font = UIFont(name: appFontBold, size: 35)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

