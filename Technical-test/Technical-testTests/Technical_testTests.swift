//
//  Technical_testTests.swift
//  Technical-testTests
//
//  Created by Ostap Romaniv on 24.05.2023.
//

import XCTest
@testable import Technical_test

final class Technical_testTests: XCTestCase {

  var dataManager: DataManager!
  
  override func setUp() {
    super.setUp()
    dataManager = DataManager()
  }
  
  override func tearDown() {
      dataManager = nil
      super.tearDown()
  }
  
  func testFetchQuotesInvalidURL() {
      let expectation = XCTestExpectation(description: "Fetch quotes with invalid URL should fail")
      
      DataManager.path = "invalid-url"
      
      dataManager.fetchQuotes { result in
          switch result {
          case .success:
              XCTFail("Fetch quotes with invalid URL should fail")
          case .failure(let error):
              XCTAssertNotNil(error, "Error should not be nil")
              expectation.fulfill()
          }
      }
      
      wait(for: [expectation], timeout: 5.0)
  }
  
}
