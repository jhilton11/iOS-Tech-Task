//
//  DataProviderMock.swift
//  MoneyBoxTests
//
//  Created by Yinka on 2024-03-24.
//

import Foundation
import Networking

public class DataProviderMock: DataProviderLogic {
    public func login(request: Networking.LoginRequest, completion: @escaping ((Result<Networking.LoginResponse, Error>) -> Void)) {
        StubData.read(file: "LoginSucceed", callback: completion)
    }
    
    public func fetchProducts(completion: @escaping ((Result<Networking.AccountResponse, Error>) -> Void)) {
        StubData.read(file: "Accounts", callback: completion)
    }
    
    public func addMoney(request: Networking.OneOffPaymentRequest, completion: @escaping ((Result<Networking.OneOffPaymentResponse, Error>) -> Void)) {
        
    }
    
}
