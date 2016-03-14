//
//  TravelTitles.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/14.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import Parse

class TravelTitles: PFObject, PFSubclassing {
    
    @NSManaged var title: String!
    @NSManaged var days: Int!
    
    //送るデータのかたまり
    init(title: String, days: Int) {
        super.init()
        self.title = title
        self.days = days
        
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecorder: NSCoder) {
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
        return "TravelTitles"
    }
}
