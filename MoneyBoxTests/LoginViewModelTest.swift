//
//  LoginViewModelTest.swift
//  MoneyBoxTests
//
//  Created by Yinka on 2024-03-24.
//

import XCTest
@testable import MoneyBox
@testable import Networking

final class LoginViewModelTest: XCTestCase {
    
    var sessionToken : String?
    var errorMessage: String?
    var expectation: XCTestExpectation?
    
    lazy var viewModel: LoginViewModel = {
        let provider = DataProviderMock()
        let viewModel = LoginViewModel(provider: provider)
        viewModel.delegate = self
        return viewModel
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        expectation = nil
    }

    func testloginSuccess() throws {
        expectation = expectation(description: "Login succeeded")
        print("Trying to login")
        viewModel.login(email: "test+ios@moneyboxapp.com", password: "P455word12")
        
        waitForExpectations(timeout: 1)
        
        let result = try XCTUnwrap(sessionToken)
        
        XCTAssertEqual(result, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=") // 5
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension LoginViewModelTest: LoginViewModelDelegate {
    func loginDidSucceed(response: Networking.LoginResponse) {
        sessionToken = response.session.bearerToken
        print("Login expectation fulfilled")
        expectation?.fulfill()
    }
    
    func loginDidFail(errorMessage: String) {
        self.errorMessage = errorMessage
        print("Error expectation fulfilled")
        expectation?.fulfill()
    }
}
