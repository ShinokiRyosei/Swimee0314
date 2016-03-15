//
//  TodoListViewController.swift
//  Swimee314
//
//  Created by KINARI NISHIYAMA on 2016/03/15.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import CTCheckbox

class TodoListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    
    
    var lightpinkColor = UIColor(red: 238/255, green: 196/255, blue: 198/255, alpha: 1.0)
    var pinkColor = UIColor(red: 208/255, green:98/255, blue:97/255, alpha: 1.0)
    var blueColor = UIColor(red: 62/255, green: 150/255, blue: 185/255, alpha: 1.0)
    var backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 236/255, alpha: 1.0)
    var yellowColor = UIColor(red: 237/255, green: 215/255, blue: 124/255, alpha: 1.0)
        
        // Tableで使用する配列を設定する
        private var myItems : [String] = Array()
        private var selected : [Bool] = Array()
        private var myTableView: UITableView!
        
        //todoリスト記入
        private var textField = UITextField()
        
        var frameView = UIView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //viewの背景色
            self.view.backgroundColor = backgroundColor
            
            //navigationvarの色指定
            self.navigationController?.navigationBar.barTintColor = pinkColor

            // Status Barの高さを取得する.
            let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
            
            // Viewの高さと幅を取得する.
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            
            // TableViewの生成する(status barの高さ分ずらして表示).
            myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
            
            // Cell名の登録をおこなう.
            myTableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "MyCell")
            
            // DataSourceの設定をする.
            myTableView.dataSource = self
            
            // Delegateを設定する.
            myTableView.delegate = self
            
            myTableView.tableFooterView = UIView()

            
            // Viewに追加する.
            self.view.addSubview(myTableView)
            
            
            //UITextFieledを作成する
            textField = UITextField(frame: CGRectMake(0,0,self.view.bounds.width,30))
            
            textField.delegate = self
            textField.layer.position = CGPoint(x:self.view.bounds.width / 2 ,y:self.view.bounds.height - 65);
            print(textField.layer.position.x)
            textField.borderStyle = UITextBorderStyle.None
            textField.backgroundColor = yellowColor
            textField.textColor = backgroundColor
            

            
            //viewに追加
            self.view.addSubview(textField)
            
            //
            self.frameView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
            
            let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
            center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
            center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        
        
        //textField
        func textFieldDidBeginEditing(textField: UITextField) {
            print("textFieldDidBeginEditing:" + textField.text!)
        }
        
        func textFieldShouldEndEditing(textField: UITextField) -> Bool {
            print("textFieldShouldEndEditing:" + textField.text!)
            return true
        }
        
        //Enterキーが押された時
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            //TableViewに表示
            myItems.append(textField.text!)
            textField.resignFirstResponder()
            
            myTableView.reloadData()
            
            //textFieldの中の文字を消す
            textField.text = ""
    
            return true
        }
        
        
        //tableview
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            print("Num: \(indexPath.row)")
            print("Value: \(myItems[indexPath.row])")
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return myItems.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! CustomTableViewCell
            
            // Cellに値を設定する.
            cell.textLabel!.text = "\(myItems[indexPath.row])"
            cell.textLabel!.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1.0)
            
            cell.checkbox.addTarget(self, action: "checked:", forControlEvents: .ValueChanged)
            cell.setData()
            
            
            return cell
        }
        
        //キーボードを上下
        func keyboardWillShow(notification: NSNotification) {
            let info:NSDictionary = notification.userInfo!
            let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
            
            let keyboardHeight: CGFloat = keyboardSize.height
            
            let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
            
            
            UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.textField.frame = CGRectMake(0, (self.view.bounds.height - keyboardHeight - 30), self.view.bounds.width, 30)
                }, completion: nil)
            print(textField.frame.origin.y)
            
        }
        
        func keyboardWillHide(notification: NSNotification) {
            let info: NSDictionary = notification.userInfo!
            //        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
            
            //        let keyboardHeight: CGFloat = keyboardSize.height
            
            let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
            
            UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.textField.frame = CGRectMake(0,(self.view.bounds.height - 80), self.view.bounds.width, 30
                )
                }, completion: nil)
        }
        
        override func viewWillDisappear(animated: Bool) {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        }
        
        
        func checked(sender:CTCheckbox) {
            
            selected.append(true)
            selected[sender.tag] = sender.checked
            
        }
    }
    
    class CustomTableViewCell: UITableViewCell
    {
        var checkbox = CTCheckbox()
        
        func setData() -> Void {
            checkbox.frame = CGRectMake(self.frame.width - 44, 0, 22, self.frame.height)
            checkbox.checkboxColor = UIColor.blackColor()
            checkbox.checkboxSideLength = 22
            self.addSubview(checkbox)
        }
        
        
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

