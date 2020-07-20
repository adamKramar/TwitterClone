//
//  Alert.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 20/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit
 
struct Alert {
 
    static func showAlert(title: String, message: String, cancel: String, ctrl: UIViewController) {
        let controller: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: cancel, style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        ctrl.present(controller, animated: true, completion: nil)
    }
    
    static func showError(message: String, ctrl: UIViewController) {
        let title = "Error"
        let ok = "Ok"
        let controller: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: ok, style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        ctrl.present(controller, animated: true, completion: nil)
    }
}
