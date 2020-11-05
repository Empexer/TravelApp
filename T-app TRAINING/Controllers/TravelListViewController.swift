//
//  TravelListViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/27/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import RealmSwift
import SwipeCellKit

class TravelListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var thereIsNoAnyTravel: UILabel!
    
    //MARK: - PRORETIES
    var travels: [Travel] = []
    var travelsNotification: NotificationToken!
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        travels = DataBaseManager.share.getTravels()
        tableView.reloadData()
        getTravelFromServer()
        getStopsFromServer()
        observTravel()
        navigationItem.hidesBackButton = true
        if travels.isEmpty == true {
            thereIsNoAnyTravel.alpha = 1
        }
        
        tableView.tableFooterView = UIView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - TABLEVIEW
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelCell", for: indexPath) as! TravelCell
        cell.delegate = self
        let travel = travels[indexPath.row]
        cell.nameLabel.text = travel.name
        cell.descriptionLabel.text = travel.description
        for star in 0..<travel.getAverageRate(){
            cell.stars[star].isHighlighted = true
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.travels.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let stopsViewController = storyboard.instantiateViewController(identifier: "StopsViewController") as! StopsViewController
        stopsViewController.travel = travels[indexPath.row]
        navigationController?.pushViewController(stopsViewController, animated: true)
        
    }
    // MARK: ACTIONS
    
    
    @IBAction func plusButton(_ sender: Any) {
        let alert = UIAlertController.init(title: "Путушествие", message: "Добавить в список", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addAction(UIAlertAction.init(title: "Добавить", style: .default, handler: { action in
            if  let travelName = alert.textFields?[0].text, let travelDescription = alert.textFields?[1].text {
                if let userId = Auth.auth().currentUser?.uid {
                    let id = UUID().uuidString
                    let travel = Travel.init(userId: userId, id: id, name: travelName, description: travelDescription)
                    self.travels.append(travel)
                    self.sendToServer(travel: travel)
                    DataBaseManager.share.saveTravelInDataBase(travel)
                    self.thereIsNoAnyTravel.alpha = 0
                    self.tableView.reloadData()
                }
            }
        }))
        alert.addAction(UIAlertAction.init(title: "Отменить", style: .cancel, handler: nil))
        alert.textFields![0].placeholder = "Название страны"
        alert.textFields![1].placeholder = "Краткое описание"
        present(alert, animated: true, completion: nil)
        
        
    }
    
    // MARK: FUNCTIONS
    
    func sendToServer(travel: Travel)  {
        let database = Database.database().reference()
        let child = database.child("travels").child("\(travel.id)")
        child.setValue(travel.json) { (error, ref) in
            if let newerror = error {
                print(newerror,ref)
            }
        }
    }
    func getTravelFromServer() {
        let database = Database.database().reference()
        database.child("travels").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            DataBaseManager.share.clear()
            self.travels.removeAll()
            for item in value.values {
                if let travelJson = item as? [String: Any] {
                    if let id = travelJson["id"] as? String,
                       let name = travelJson["name"] as? String,
                       let description = travelJson["description"] as? String,
                       let userId = Auth.auth().currentUser?.uid {
                        let travel = Travel(userId: userId, id: id, name: name, description: description)
                        self.travels.append(travel)
                        self.tableView.reloadData()
                        
                    }
                }
            }
        }
    }
    func getStopsFromServer() {
        let database = Database.database().reference()
        database.child("stops").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            for item in value.values {
                if let stopJson = item as? [String: Any] {
                    if let id = stopJson["id"] as? String, let travelID  = stopJson["travelId"] as? String {
                        let stop = Stop.init(id: id, travelId: travelID)
                        if let name = stopJson["name"] as? String {
                            stop.name = name
                        }
                        if let rate = stopJson["rate"] as? Int {
                            stop.rate = rate
                        }
                        if let location = stopJson["location"] as? String {
                            let components = location.components(separatedBy: "-")
                            if let xpString = components.first, let ypString = components.last, let xp = Double(xpString), let yp = Double(ypString) {
                                stop.location = CGPoint(x: xp, y: yp)
                            }
                        }
                        if let spentMoneyString = stopJson["spentMoney"] as? String,
                           let currency = Currency(rawValue: spentMoneyString) {
                            
                        }
                        if let transportInt  = stopJson["transport"] as? Int, let transport = Transport.init(rawValue: transportInt) {
                            stop.transport = transport
                        }
                        if let decsription = stopJson["decsription"] as? String {
                            stop.decsription = decsription
                        }
                        for travel in self.travels {
                            if travel.id == travelID {
                                travel.stops.append(stop)
                            }
                            self.tableView.reloadData()
                        }
                        
                    }
                }
            }
            for travel in self.travels {
                DataBaseManager.share.saveTravelInDataBase(travel)
            }
        }
    }
    func observTravel() {
        let realm = try! Realm()
        let travels = realm.objects(RLMTravel.self)
        travelsNotification = travels.observe { (changes ) in
            switch changes {
            
            case .initial(_):
                break
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                print("Did update travels")
            case .error(_):
                break
            }
        }
    }
}
//        }
//    }

