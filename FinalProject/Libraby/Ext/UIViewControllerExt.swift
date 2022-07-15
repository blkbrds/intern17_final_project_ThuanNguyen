//
//  UIViewControllerExt.swift
//  FinalProject
//
//  Created by thuan.nguyen on 04/07/2022.
//

import Foundation
import UIKit

extension UIViewController {

    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
    }

}

