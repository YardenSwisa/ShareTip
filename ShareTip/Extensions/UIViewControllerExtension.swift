//
//  UIViewControllerExtention.swift
//  ShareTip
//
//  Created by YardenSwisa on 25/05/2021.
//  Copyright © 2021 YardenSwisa. All rights reserved.
//

import UIKit

//MARK: Hide/Dismiss Keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
