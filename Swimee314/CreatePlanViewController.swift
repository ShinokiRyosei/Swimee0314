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

class CreatePlanViewController: UIViewController, UITextFieldDelegate, UIActionSheetDelegate {

    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var daysTextField: UITextField!
    var days: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        projectTextField.delegate = self
        daysTextField.delegate = self
        
        projectTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func create() {
        guard let text = projectTextField.text else { return }
//        TravelTitles(title: projectTextField.text!, days: <#T##Int#>)
    }
    
    func picker(sender: UITextField) {
        
        var daysArray = [Int]()
        
        for i in 1 ... 10 {
            daysArray.append(i)
        }
        
//        ActionSheetStringPicker.showPickerWithTitle("旅行の日数を選んでください", rows: daysArray, initialSelection: 0, target: "decideDays", successAction: nil, cancelAction: nil, origin: sender)
        let actionSheet = ActionSheetStringPicker(title: "旅行の日数を選んでください", rows: daysArray, initialSelection: 0, doneBlock: { (picker, selectedIndex, id) -> Void in self.decideDays(selectedIndex+1)
            }, cancelBlock: nil, origin: sender)
        actionSheet.showActionSheetPicker()
//        let actionSheet = ActionSheetStringPicker(title: "choice person", rows: daysArray, initialSelection: 0, doneBlock: {(picker, selectedIndex, id) -> Void in print("picker...\(picker), selectedIndex...\(selectedIndex), id...\(id)")
//            
//            self.personNumber = selectedIndex + 1
//            self.personLabel.text = person[selectedIndex] as! String
//            self.Egg()
//            
//            }, cancelBlock: { (picker) -> Void in
//                print("\(picker)")
//            }, origin: sender)
//        
//        
//        
//        
//        actionSheet.showActionSheetPicker()
    }
    
    func decideDays(id: Int) {
        daysTextField.text = "\(id)日"
    }
    
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.picker(textField)
        return false
    }
    
    
    
    


}
