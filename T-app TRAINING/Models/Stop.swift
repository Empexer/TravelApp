//
//  Stop.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/27/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import RealmSwift

enum Transport: Int, RealmEnum  {
    case none
    case car
    case airplain
    case train
}

class Stop {
    var id: String
    var travelId: String
    var name: String = ""
    var rate: Int = 0
    var location: CGPoint = .zero  //x=0 y = 0
    var spentMoney: String = ""
    var transport: Transport = .none
    var currency: Currency = .none
    var decsription: String = ""
    
    init(id: String, travelId: String  ) {
        self.id = id
        self.travelId = travelId
    }
    
    
    var json: [String: Any] {
        return ["id": id,
                "travelId": travelId,
                "name": name,
                "rate": rate,
                "location": "\(location.x) - \(location.y)",
                "spentMoney": spentMoney,
                "transport": transport.rawValue,
                "description": decsription]
    }
}
