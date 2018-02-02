//
//  GradientView.swift
//  HDFC_Investor
//
//  Created by Ashish Jain on 18/05/17.
//  Copyright © 2017 TTN. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5,y: 0.0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5,y: 1.0)
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: frame.size.width,
                                height: frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}

import Foundation
import UIKit
@IBDesignable final class GradientProgressView: UIView {
    var progress: Double = 50
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: frame.size.width,
                                height: frame.size.height)
        gradient.colors = [UIColor.brightLightBlue, UIColor.lightGreenishBlue]
        gradient.startPoint = CGPoint(x: 0.0,y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.5)
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}

//My...
import Foundation
import UIKit
@IBDesignable final class GradientButton: UIButton {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0,y: 0.0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.0,y: 0.0)
    override func draw(_ rect: CGRect) { 
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: frame.size.width,
                                height: frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}

/*
 let attributedString = NSMutableAttributedString(string: "North Korea: The Hidden Revolution", attributes: [
 NSFontAttributeName: UIFont(name: "SemplicitaPro-Bold", size: 15.0)!,
 NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 1.0),
 NSKernAttributeName: -0.19
 ])
 attributedString.addAttribute(NSKernAttributeName, value: -0.19, range: NSRange(location: 33, length: 1))
 

//For Label
import Foundation
import UIKit
@IBDesignable final class fontClass: UILabel {
    @IBInspectable var fontName: UIFont = UIFont(name: "SemplicitaPro-Bold", size: 19.0)!
    @IBInspectable var fontSize: CGFloat = CGFloat()
    @IBInspectable var fontColor: UIColor = UIColor()
    
}
*/

