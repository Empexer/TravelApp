//
//  EnterSpendedMoney.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/26/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import RealmSwift

enum Currency: String,RealmEnum   {
    case none = ""
    case ruble = "₽"
    case dollar = "$"
    case euro = "€"
}

protocol SpentMoneyViewControllerDelegate {
    func spent(money: Int , currency: Currency)
}

class SpentMoneyViewController: UIViewController {
    
    
    //MARK: - OUTLETS
    var delegate: CreateYourStopViewController?
    var value: Int = 0
    var delegateStopToTravel: TravelListViewController?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentMoney: UISegmentedControl!
    
    
    @IBOutlet weak var readyButton: UIButton!
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCorners(button: readyButton, radius: 4)
        segmentMoney.selectedSegmentTintColor = #colorLiteral(red: 0.5137254902, green: 0.537254902, blue: 0.9098039216, alpha: 1)
        let customcolor = UIColor(red: 0.518, green: 0.528, blue: 0.910, alpha: 1)
        segmentMoney.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentMoney.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: customcolor], for: .normal)
    }
    //MARK: - Action
    @IBAction func readyClicked(_ sender: Any) {
        if let text = textField.text, let money = Double(text) {
            if segmentMoney.selectedSegmentIndex == 0 {
                delegate?.spent(money: money, currency: .dollar)
            } else if segmentMoney.selectedSegmentIndex == 1 {
                delegate?.spent(money: money, currency: .euro)
            } else if segmentMoney.selectedSegmentIndex == 2 {
                delegate?.spent(money: money, currency: .ruble)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Functions
    
}
