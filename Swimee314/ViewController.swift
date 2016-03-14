//
//  ViewController.swift
//  Swimee314
//
//  Created by 岩本果純 on 2016/03/14.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import PageMenu


class ViewController: UIViewController, CAPSPageMenuDelegate {
    //PageMenuのインスタンス
    var pageMenu: CAPSPageMenu!
    
    var travelDays: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var controllersArray = [UIViewController]()
        
        for i in 1 ... travelDays {
            let controller = ScheduleListViewController(nibName: "ScheduleListViewController", bundle: nil)
            controller.title = "\(i) 日目"
            controllersArray.append(controller)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

