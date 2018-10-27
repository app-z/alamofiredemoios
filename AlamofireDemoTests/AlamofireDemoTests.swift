//
//  AlamofireDemoTests.swift
//  AlamofireDemoTests
//
//  Created by Dmitry on 10/25/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import XCTest
@testable import AlamofireDemo

class AlamofireDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
class TheMoviesPageTests: XCTestCase {
        
        override func setUp() {
            super.setUp()
        }

        func testExample(){
            let expec = expectation(description: "get movies")
            let registrationPresenter = MoviesPresenter(delegate: MockUIViewController1(expectation: expec))
            registrationPresenter.requestMovies()
            wait(for: [expec], timeout: 3)
        }
    }
    
    //there are the mock of UIviewController which using the Presenter
    class MockUIViewController1: MoviesDelegate{
        
        var expec: XCTestExpectation
        init(expectation: XCTestExpectation) {
            self.expec = expectation
        }
        func showProgress(){}
        func hideProgress(){}
        func moviesDidSucceed() {
            self.expec.fulfill()
        }
        
        func moviesDidFailed(code: Int, error: String) {
//            XCTAssertEqual(error, "???")
            print("!!!")
            self.expec.fulfill()
        }
    }

}
