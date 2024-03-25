//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Yinka on 2024-03-22.
//

import Foundation
import Networking

class LoginViewModel {
    
    let dataProvider: DataProviderLogic?
    weak var delegate: LoginViewModelDelegate?
    var name = ""
    
    init(provider: DataProviderLogic) {
        self.dataProvider = provider
    }
    
    public func login(email: String = "test+ios@moneyboxapp.com", password: String = "P455word12") {
        let request = LoginRequest(email: email, password: password)
        dataProvider?.login(request: request) { [weak self]
            result in
            
            switch (result) {
            case .success(let response):
                //print("Response is \(response)")
//                self?.name = "\(response.user.firstName ?? "") \(response.user.lastName ?? "")"
                SessionManager().setUserToken(response.session.bearerToken)
                self?.delegate?.loginDidSucceed(response: response)
            case .failure(let error):
                print("Error is \(error)")
                self?.delegate?.loginDidFail(errorMessage: error.localizedDescription)
            }
        }
    }
    
}

public protocol LoginViewModelDelegate: AnyObject {
    func loginDidSucceed(response: LoginResponse)
    
    func loginDidFail(errorMessage: String)
}
