//
//  ExploreCategoryPickerViewController.swift
//  Magellan
//
//  Created by Ashish Jain on 09/12/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

protocol ExploreCategoryPickerViewControllerProtocol: class {
    func didSelectCategory(selectedRow: Int)
}

class ExploreCategoryPickerViewController: UIViewController {

    var categoryDataSource: [String]?
    var selectIndexpath: Int = 0
    weak var delegate: ExploreCategoryPickerViewControllerProtocol?

    @IBOutlet weak var pickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func crossButtonAction(_ sender: Any) {
        delegate?.didSelectCategory(selectedRow: pickerView.selectedRow(inComponent: 0))
        dismiss(animated: true, completion: nil)
    }

}

extension ExploreCategoryPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryDataSource?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: categoryDataSource![row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }

}
