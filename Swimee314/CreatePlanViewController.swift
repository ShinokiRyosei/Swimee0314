//
//  CreatePlanViewController.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/14.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import Parse
import ActionSheetPicker_3_0
import SVProgressHUD
import Realm
import RealmSwift

class CreatePlanViewController: UIViewController, UITextFieldDelegate, UIActionSheetDelegate {

    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var daysTextField: UITextField!
    var days: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        projectTextField.delegate = self
        daysTextField.delegate = self
        
//        projectTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        projectTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func sendBtn(sender: AnyObject) {
        self.create()
    }
    
    
    func create() {
        guard let text = projectTextField.text else {
            Alert.showAlertView("旅行のタイトルを入れてください", messageText: "タイトルなしでは行程を作成できません", buttonTitle: "OK")
            return }
        guard let day: String = String(days) else {
            Alert.showAlertView("旅行の日数を記入してください", messageText: "日数なしでは行程を作成できません", buttonTitle: "OK")
            return
        }
        
        let realm = try! Realm()
        
        SVProgressHUD.show()
        let data = TravelTitles(title: text, days: String(day))
        
        data.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            
            
            if !succeeded {
                print("\(error?.localizedDescription)")
            }
            
            let travel = data.objectId
            let realmModel = TravelTitleRealmModel()
            realmModel.travelTitle = text
            realmModel.objectId = travel!
            realmModel.days = Int(day)!
            
            
            
            
        
            SVProgressHUD.showSuccessWithStatus("作成完了")
            try! realm.write({
                realm.add(realmModel)
            })
            self.tabBarController?.selectedIndex = 2
            
        }
        
    }
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func picker(sender: UITextField) {
        
        var daysArray = [Int]()
        
        for i in 1 ... 10 {
            daysArray.append(i)
        }
        

        let actionSheet = ActionSheetStringPicker(title: "旅行の日数を選んでください", rows: daysArray, initialSelection: 0, doneBlock: { (picker, selectedIndex, id) -> Void in self.decideDays(selectedIndex+1)
            }, cancelBlock: nil, origin: sender)
        actionSheet.showActionSheetPicker()
    }
    
    func decideDays(id: Int) {
        daysTextField.text = "\(id)日"
        days = id
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField == projectTextField {
            textField.resignFirstResponder()
        }
        
        return true
        
        
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == daysTextField {
            self.view.endEditing(true)
            self.picker(textField)
            return false
        }else {
            return true
        }
    }
    
    
    
    


}
