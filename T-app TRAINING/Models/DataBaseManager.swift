//
//  DataBaseManager.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 11/2/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseManager {
    static let share = DataBaseManager()
    func saveTravelInDataBase( _ travel: Travel ) {
        let rlmTravel = travel.toRealm()
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(rlmTravel, update: .all)
        try! realm.commitWrite()
    }
    
    func getTravels() -> [Travel] {
        var result: [Travel] = []
        let realm = try! Realm()
        let rlmTravels = realm.objects(RLMTravel.self)
        for rlmTravel in rlmTravels  {
            let travel = rlmTravel.toObject()
            result.append(travel)
            
        }
        return result
    }
    func clear() {
        let realm = try! Realm()
        let rlmTravels = realm.objects(RLMTravel.self)
        let rlmStops = realm.objects(RLMStop.self)
        realm.delete(rlmTravels)
        realm.delete(rlmStops)
    }
}
