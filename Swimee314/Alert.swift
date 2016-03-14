//
//  Alert.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/15.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit

class Alert: UIAlertView {

    static func showAlertView(titleText: String, messageText: String, buttonTitle: String) {
        let alert = UIAlertView(title: titleText, message: messageText, delegate: self, cancelButtonTitle: buttonTitle)
        alert.show()
        
    }

}
