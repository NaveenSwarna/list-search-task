//
//  ListSearch_TaskTests.swift
//  ListSearch_TaskTests
//
//  Created by Admin on 12/13/20.
//

import XCTest
@testable import ListSearch_Task

class ListSearch_TaskTests: XCTestCase {

	var viewModel =  MovieViewModel()
	
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		viewModel.movieDidChanges = { (finished, error) in
			if !error {
				XCTAssertEqual(finished, true, "Api call successful")
			}
		}
		viewModel.fetchMovieList()
		
		
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
			
			MovieAPIService.instance.fetchMovies { (result) in
				print(result)
			}
        }
    }

}
