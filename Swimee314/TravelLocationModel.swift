//
//  TravelLocationModel.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/16.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//
//
//import UIKit
//import Parse
//
//class TravelLocationModel: PFObject, PFSubclassing {
//    
//    init() {
//        super.init()
//    }
//    
//    override init() {
//        super.init()
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override class func initialize() {
//        struct Static {
//            static var onceToken: dispatch_once_t = 0
//        }
//        
//        dispatch_once(&Static.onceToken) {
//            self.registerSubclass()
//        }
//    }
//    
//    static func parseClassName() -> String {
//        return "Locations"
//    }
//    
//
//}
