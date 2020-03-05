//
//  UIViewController+Alerts.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String?, message: String?) {
        let alertController  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
