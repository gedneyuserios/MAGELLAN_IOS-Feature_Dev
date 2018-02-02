//
//  ProgressBar.swift
//  HDFC_Investor
//
//  Created by Sandeep on 5/16/17.
//  Copyright © 2017 TTN. All rights reserved.
//

import Foundation
import PKHUD

func showLoader() {
    HUD.show(.progress)
}
func hideLoader() {
    HUD.flash(.progress, delay: 0.0)
}
