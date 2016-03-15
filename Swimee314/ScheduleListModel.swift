//
//  ScheduleListModel.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/15.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import Parse

class ScheduleListModel: PFObject, PFSubclassing {
    
    @NSManaged var travelId: PFObject!
    @NSManaged var day: String!
    @NSManaged var content: String!
    @NSManaged var time: String!
    
    
    init(travelId: PFObject, day: String, content: String, time: String) {
        super.init()
        
        self.travelId = travelId
        self.day = day
        self.content = content
        self.time = time
    }
    
    override init() {
        super.init()
    }
    
    required init(code aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Schedule"
    }
}
