//
//  UtilFunctions.swift
//  MoneyBox
//
//  Created by student on 2024-03-25.
//

import Foundation
import UIKit

class Utilities {
    
    static func createAlert(vc: UIViewController, title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(action)
        vc.present(alertVC, animated: true)
    }
    
}
