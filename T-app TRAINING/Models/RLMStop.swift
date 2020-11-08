//
//  RLMStop.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 11/2/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import Foundation

import RealmSwift

class RLMStop: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var travelId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var rate: Int = 0
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var spentMoney: Double = 0
    dynamic var transport: Transport = .none
    dynamic var currency: Currency = .none
    @objc dynamic var desc: String = ""
    
    override static func primaryKey() -> String? {
        return #keyPath(RLMStop.id)
    }
}
