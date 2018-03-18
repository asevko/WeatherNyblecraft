//
//  UIViewControllerExtension.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/15/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
