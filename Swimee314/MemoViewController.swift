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

class MemoViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var contentTextView:UITextView!
    @IBOutlet var addScroll: UIScrollView!
    
    var txtActiveField: UITextView! //編集後のtextFieldを新しく格納する変数を定義
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentTextView.delegate = self //デリゲート設定
    }
    // Viewが画面に表示される度に呼ばれるメソッド
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        contentTextView.resignFirstResponder()
        
        // NSNotificationCenterへの登録処理
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Viewが非表示になるたびに呼び出されるメソッド
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // NSNotificationCenterの解除処理
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    //画面がタップされた際にキーボードを閉じる処理
    func tapGesture(sender: UITapGestureRecognizer) {
        contentTextView.resignFirstResponder()
    }
    
    //キーボードのreturnが押された際にキーボードを閉じる処理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        contentTextView.resignFirstResponder()
        //itemMemo.resignFirstResponder()
        return true
    }
    
    @IBAction func saveMemo(){
        guard let text = contentTextView.text else { return }
        let myMemo = Memo()
        myMemo.memo = text
        try! realm.write {
            realm.add(myMemo)
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
