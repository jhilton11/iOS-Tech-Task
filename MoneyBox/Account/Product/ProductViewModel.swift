//
//  ProductViewModel.swift
//  MoneyBox
//
//  Created by student on 2024-03-24.
//

import Foundation
import Networking

class ProductViewModel {
    
    var dataprovider: DataProviderLogic
    weak var delegate: ProductViewModelDelegate?
    
    init(provider: DataProviderLogic) {
        self.dataprovider = provider
    }
    
    func addPayment(request: OneOffPaymentRequest) {
        dataprovider.addMoney(request: request) { [weak self]
            result in
            
            switch (result) {
            case .success(let response):
                self?.delegate?.didReceiveResponse()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
}

public protocol ProductViewModelDelegate: AnyObject {
    func didReceiveResponse()
    
    func loginDidFail(errorMessage: String)
}
