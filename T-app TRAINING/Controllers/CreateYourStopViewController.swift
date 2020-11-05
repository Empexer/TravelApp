//
//  CreateYourStopViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/26/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateYourStopViewController: UIViewController {
    
    var dataStop: Stop?
    var delegate: StopsViewController?
    var travelId: String = ""
    
    
    
    
    let customcolor = UIColor(red: 0.518, green: 0.528, blue: 0.910, alpha: 1)
    
    
    //MARK: - OUTLETS
    @IBOutlet weak var sumFull: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    @IBOutlet weak var nameLabelTextField: UITextField!
    @IBOutlet weak var changingRateLabel: UILabel!
    
    @IBOutlet weak var geolocationLabel: UILabel!
    
    
    @IBOutlet weak var stepperView: UIView!
    
    @IBOutlet weak var dotsAnimationView: DotsActivityIndicator!
    var money: String = ""
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        dotsAnimationView.isOpaque = true
        stepperView.layer.borderColor = #colorLiteral(red: 0.5137254902, green: 0.537254902, blue: 0.9098039216, alpha: 1)
        stepperView.layer.borderWidth = 1
        nameLabelTextField.text = dataStop?.name
        descriptionTextView.text = dataStop?.name
        changingRateLabel.text = String(dataStop?.rate ?? 0)
        sumFull.text = dataStop?.spentMoney
        
        if dataStop?.transport == .airplain {
            segmentedControlLabel.selectedSegmentIndex = 0
        }
        else if dataStop?.transport == .train {
            segmentedControlLabel.selectedSegmentIndex = 1
            
        } else if dataStop?.transport == .car {
            segmentedControlLabel.selectedSegmentIndex = 2
        }
        
        descriptionTextView.contentInset.left = 16
        descriptionTextView.contentInset.right = 16
        if let dataStop = dataStop {
            sumFull.text = "\(dataStop.spentMoney)"
            
            
        }
        borderWidth(width: 1, button: stepperView)
        changecolor(button: stepperView)
        borderWidth(width: 1, button: stepperView)
        stepperView.layer.borderColor = #colorLiteral(red: 0.5137254902, green: 0.537254902, blue: 0.9098039216, alpha: 1)
        stepperView.layer.cornerRadius = 5
        
    }
    //MARK: -   ACTIONS
    @IBAction func mapButton(_ sender: Any) {
        let mapVC = MapViewController.fromStoryboard() as! MapViewController
        navigationController?.pushViewController(mapVC, animated: true)
        mapVC.closure =  { point in
            self.geolocationLabel.text = "\(point.x) - \(point.y)"
        }
    }
    
    @IBAction func chooseСurrency(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let spendMoney = storyboard.instantiateViewController(identifier: "EnterSpendedMoney") as! SpentMoneyViewController
        spendMoney.delegate = self
        navigationController?.pushViewController(spendMoney, animated: true)
    }
    @IBAction func plusRateButton(_ sender: Any) {
        if let text = changingRateLabel.text, let currentValue = Int(text) {
            changingRateLabel.text = String(currentValue + 1)
            if currentValue >= 5 {
                changingRateLabel.text = String(5)
            }
        }
    }
    @IBAction func minusRateButton(_ sender: Any) {
        if let text = changingRateLabel.text, let currentValue = Int(text) {
            changingRateLabel.text = String(currentValue - 1)
            if currentValue <= 0 {
                changingRateLabel.text = String(0)
            }
        }
    }
    @IBAction func addGeolocationButton(_ sender: Any) {
    }
    @IBAction func segmentedControlButton(_ sender: Any) {
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if let dataStop = dataStop {
            update(stop: dataStop)
            delegate?.didUpdate(stop: dataStop)
            sendToServer(stop: dataStop) 
            
        } else {
            let id = UUID().uuidString
            let stop = Stop(id: id, travelId: travelId )
            update(stop: stop)
            delegate?.didCreateStop(stop)
            sendToServer(stop: stop)
            
        }
        dotsAnimationView.startAnimation()
        dotsAnimationView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.dotsAnimationView.stopAnimation()
            self.navigationController?.popViewController(animated: true )
            
        })
        
        
        
        
    }
    
    
    
    //MARK: - FUNCTIONS
    func update(stop: Stop) {
        stop.name = nameLabelTextField.text ?? ""
        
        stop.location = .zero
        
        if segmentedControlLabel.selectedSegmentIndex == 0  {
            stop.transport = .airplain
        }   else if segmentedControlLabel.selectedSegmentIndex == 1 {
            stop.transport = .train
        } else if segmentedControlLabel.selectedSegmentIndex == 2 {
            stop.transport  = .car
        }
        stop.spentMoney = sumFull.text ?? ""
        stop.rate = Int(changingRateLabel.text ?? "") ?? 0
        stop.decsription = descriptionTextView.text
        
        
    }
    func borderWidth(width: CGFloat, button: UIView) {
        button.layer.borderWidth = width
    }
    func changecolor(button: UIView) {
        button.tintColor = customcolor
    }
    func spent(money: String, currency: Currency) {
        self.money = money
        sumFull.text = money + currency.rawValue
    }
    func sendToServer(stop: Stop)  {
        let database = Database.database().reference()
        let child = database.child("stops").child("\(stop.id)")
        child.setValue(stop.json) { (error, ref) in
            if let newerror = error {
                print(newerror,ref)
            }
            
            
        }
    }
    
    
}


