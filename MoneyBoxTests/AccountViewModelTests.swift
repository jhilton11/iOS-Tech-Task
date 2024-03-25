//
//  AccountViewModelTests.swift
//  MoneyBoxTests
//
//  Created by Yinka on 2024-03-25.
//

import XCTest
@testable import MoneyBox

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
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel.products = []
        viewModel.totalPlanValue = 0.0
    }

    func testFetchProducts() throws {
        expectation = expectation(description: "fetch products")
        
        viewModel.getProducts()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(viewModel.products.count, 2)
    }
    
    func testPlanValue() throws {
        expectation = expectation(description: "get planValue")
        
        viewModel.getProducts()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(viewModel.totalPlanValue, 15707.080000)
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
        expectation?.fulfill()
    }
}
