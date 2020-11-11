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
    
    func getObjects<T: Object>(classType: T.Type) -> [T] {
        var result: [T] = []
        let realm = try! Realm()
        let objects = realm.objects(T.self)
        for object in objects  {
            result.append(object)
            
        }
        return result
    }
    func clear() {
        let realm = try! Realm()
        let rlmTravels = realm.objects(RLMTravel.self)
        let rlmStops = realm.objects(RLMStop.self)
        try! realm.write {
            realm.delete(rlmTravels)
            realm.delete(rlmStops)
        }
    }
    
}
