//
//  Travel.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/27/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit

class Travel {
    var userId: String
    var id: String
    var name: String
    var description: String
    var stops: [Stop] = []
    
    
    
    init(userId: String, id: String, name: String, description: String) {
        self.userId = userId
        self.id = id
        self.name = name
        self.description = description
        
    }
    
    func getAverageRate() -> Int {
        guard stops.count > 0 else {return 0}
        var sum = 0
        for stop in stops {
            sum += stop.rate
        }
        return sum/stops.count
        
    }
    var json: [String: Any] {
        return ["id": id,
                "name": name,
                "description": description,
                "stops": stops.map ({$0.json})]
    }
}

extension Travel {
    func toRealm() -> RLMTravel {
        let rlmTravel = RLMTravel()
        rlmTravel.id = self.id
        rlmTravel.userId = self.userId
        rlmTravel.name = self.name
        rlmTravel.desc = self.description
        for stop in self.stops {
            let rlmStop = RLMStop()
            rlmStop.id = stop.id
            rlmStop.travelId = stop.travelId
            rlmStop.name = stop.name
            rlmStop.rate = stop.rate
            rlmStop.latitude = Double(stop.location.x)
            rlmStop.longitude = Double(stop.location.y)
            rlmStop.spentMoney = stop.spentMoney
            rlmStop.transport = stop.transport
            rlmStop.desc = stop.decsription
            rlmTravel.stops.append(rlmStop)
        }
        return rlmTravel
    }
}

