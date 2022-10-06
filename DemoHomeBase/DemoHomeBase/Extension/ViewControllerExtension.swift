//
//  ViewControllerExtension.swift
//  DemoHomeBase

import Foundation
extension UIViewController {
    
    @objc func popVC() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

}

