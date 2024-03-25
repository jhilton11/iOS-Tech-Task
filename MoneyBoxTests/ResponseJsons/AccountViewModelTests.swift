//
//  AccountViewModelTests.swift
//  MoneyBoxTests
//
//  Created by student on 2024-03-25.
//

import XCTest
@testable import MoneyBox
@testable import Networking

final class AccountViewModelTests: XCTestCase {
    
    var expectation: XCTestExpectation?
    
    lazy var viewModel: AccountUserViewModel = {
        let provider = DataProviderMock()
        let viewModel = AccountUserViewModel(provider: provider)
        viewModel.delegate = self
        return viewModel
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        SessionManager().setUserToken("GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        SessionManager().removeUserToken()
    }

    func testFetchProducts() throws {
        expectation = expectation(description: "fetch products")
        print("Trying to fetch")
        viewModel.getProducts()
        
        waitForExpectations(timeout: 1)
        
//        let result = try XCTUnwrap()
        
        XCTAssertEqual(viewModel.products.count, 3) // 5
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension AccountViewModelTests: AccountUserViewModelDelegate {
    func didReceiveResponse() {
        expectation?.fulfill()
    }
    
    func loginDidFail(errorMessage: String) {
        print("Got an error")
        expectation?.fulfill()
    }
}
