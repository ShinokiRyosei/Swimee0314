//
//  MemoViewController.swift
//  Swimee314
//
//  Created by 岩本果純 on 2016/03/14.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class MemoViewController: UIViewController {
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var contentTextView:UITextView!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveMemo(){
    
        let myMemo = Memo()
        myMemo.memo = contentTextView.text
        try! realm.write {
            realm.add(myMemo)
        }
    }
    
    

    

}
