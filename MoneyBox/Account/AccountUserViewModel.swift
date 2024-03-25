//
//  AccountUserViewModel.swift
//  MoneyBox
//
//  Created by Yinka on 2024-03-23.
//

import Foundation
import Networking

class AccountUserViewModel {
    
    weak var delegate: AccountUserViewModelDelegate?
    var dataprovider: DataProvider?
    
    var products = [ProductResponse]()
    var totalPlanValue = 0.0
    var errorMessage = ""
    
    init(provider: DataProviderLogic) {
        self.dataprovider = provider as? DataProvider
    }
    
    func getProducts() {
        dataprovider?.fetchProducts { [weak self]
            result in
            switch (result) {
            case (.success(let response)):
                print(response)
                self?.totalPlanValue = response.totalPlanValue ?? 0.0
                self?.products = response.productResponses ?? []
                self?.delegate?.didReceiveResponse()
            case (.failure(let error)):
                print(error)
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
}

public protocol AccountUserViewModelDelegate: AnyObject {
    func didReceiveResponse()
    
    func loginDidFail(errorMessage: String)
}
