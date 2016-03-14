//
//  TableViewController.swift
//  Swimee314
//
//  Created by 岩本果純 on 2016/03/14.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit

class MemoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        table.registerNib(UINib(nibName: "MemoListTableViewCell", bundle: nil), forCellReuseIdentifier: "MemoListCell")
        
        table.delegate = self
        table.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //繰り返すCellのメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier("MemoListCell", forIndexPath: indexPath) as! MemoListTableViewCell
        return cell
    }
    
    //セルの数のメソッド
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //セルがタップされたときに呼ばれるメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        segueToMemoVC()
    }
    
    //MemoViewControllerへの遷移メソッド
    private func segueToMemoVC() {
        self.performSegueWithIdentifier("toMemoVC", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //MemoViewControllerへの遷移時に渡すもののメソッド
        if segue.identifier == "toMemoVC" {
            
        }
    }
    
    

}
