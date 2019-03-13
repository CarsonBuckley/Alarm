//
//  Alarm.swift
//  Alarm2
//
//  Created by Carson Buckley on 3/11/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable {
    
    var fireDate: Date
    var name: String
    var enabled: Bool = false
    var uuid: String
    
    init(fireDate: Date, name: String, enabled: Bool = false, uuid: String = UUID().uuidString) {
        
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
        
    }
    
    var fireTimeAsString: String {
    let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: fireDate)
    
    }
    
}

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}
