//
//  StopsViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 9/3/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwipeCellKit

class StopsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, SwipeTableViewCellDelegate {
    
    
    
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var travel: Travel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    //MARK: - Functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let createStop = storyboard.instantiateViewController(identifier: "CreateYourStopViewController") as! CreateYourStopViewController
        createStop.delegate = self
        createStop.travelId = travel?.id ?? ""
        createStop.existingStop = travel?.stops[indexPath.row]
        navigationController?.pushViewController(createStop, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travel?.stops.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath) as! StopCell
        cell.delegate = self
        if let stop = travel?.stops[indexPath.row] {
            cell.nameLabel.text = stop.name
            cell.descriptionOfStop.text = stop.decsription
            cell.spendMoney.text = stop.spentMoneyText
            
            if stop.rate == 1 {
                (cell.rateStack.viewWithTag(1) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                
            } else if stop.rate == 2 {
                (cell.rateStack.viewWithTag(1) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(2) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                
            } else if stop.rate == 3 {
                (cell.rateStack.viewWithTag(1) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(2) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(3) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                
            }  else if stop.rate == 4 {
                (cell.rateStack.viewWithTag(1) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(2) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(3) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(4) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                
            } else if stop.rate == 5 {
                (cell.rateStack.viewWithTag(1) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(2) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(3) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(4) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
                (cell.rateStack.viewWithTag(5) as? UIImageView)?.image = #imageLiteral(resourceName: "Star Icon")
            }
            if stop.transport == .airplain {
                cell.transportImage.image = #imageLiteral(resourceName: "Group")
            } else if stop.transport == .train {
                cell.transportImage.image = #imageLiteral(resourceName: "train")
            } else if stop.transport == .car {
                cell.transportImage.image = #imageLiteral(resourceName: "car")
                
            }
            
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.travel?.stops.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        return [deleteAction]
    }
    
    func didCreateStop(_ stop: Stop) {
        travel?.stops.append(stop)
        tableView.reloadData()
        DataBaseManager.share.saveTravelInDataBase(travel!)
    }
    func didUpdate(stop: Stop) {
        if let indexPath = tableView.indexPathForSelectedRow {
            travel?.stops[indexPath.row] = stop
            tableView.reloadData()
            DataBaseManager.share.saveTravelInDataBase(travel!)
            
        }
        
    }
    
    
    
    //MARK: - Actions
    
    @IBAction func addStopPlus(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let createStop = storyboard.instantiateViewController(identifier: "CreateYourStopViewController") as! CreateYourStopViewController
        createStop.travelId = travel?.id ?? ""
        navigationController?.pushViewController(createStop, animated: true)
        createStop.delegate = self
        
        
    }
    
    
    
}


