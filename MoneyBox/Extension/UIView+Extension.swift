//
//  UIView+Extension.swift
//  MoneyBox
//
//  Created by student on 2024-03-25.
//

import Foundation
import UIKit

extension UIView {
    
    func addBorder() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
    }
    
}
