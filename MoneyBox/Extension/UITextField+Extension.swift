//
//  UITextField+Extension.swift
//  MoneyBox
//
//  Created by Yinka on 2024-03-25.
//

import Foundation
import UIKit

extension UITextField {
    
    func addLeftPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRectMake(0, 0, padding, self.frame.height))
        leftView = paddingView
        leftViewMode = UITextField.ViewMode.always
    }
    
}

