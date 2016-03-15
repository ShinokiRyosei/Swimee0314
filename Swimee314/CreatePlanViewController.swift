//
//  CreatePlanViewController.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/14.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD
import Realm
import RealmSwift

class CreatePlanViewController: UIViewController, UITextFieldDelegate, UIActionSheetDelegate {

    @IBOutlet weak var projectTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        projectTextField.delegate = self
        
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
        self.create()
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
        
        
        
        SVProgressHUD.show()
        let data = TravelTitles(title: text)
        
        data.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            
            
            if !succeeded {
                print("\(error?.localizedDescription)")
            }
            
            SVProgressHUD.showSuccessWithStatus("作成完了")
            self.tabBarController?.selectedIndex = 2
        }
        
    }
    
    
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    
    
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField == projectTextField {
            textField.resignFirstResponder()
        }
        
        return true
        
        
    }
    
    
    
    
    
    
    


}
