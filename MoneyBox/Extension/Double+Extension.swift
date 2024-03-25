//
//  Double+Extension.swift
//  MoneyBox
//
//  Created by student on 2024-03-24.
//

import Foundation

extension Double {
    
    func formatToCurrency() -> String {
        return self.formatted(.currency(code: "GBP"))
    }
    
}
