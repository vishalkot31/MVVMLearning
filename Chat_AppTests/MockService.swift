//
//  MockService.swift
//  BookwormTests
//
//  Created by Vishal Kothari on 24/12/25.
//

import XCTest
@testable import MVVMLearning
@MainActor
final class MockServiceTests: XCTestCase {

    var apiService: MockMopvieService!
    var viewModel : MovieListViewModel!
    override func setUp() {
        super.setUp()
        apiService  = MockMopvieService()
        viewModel = MovieListViewModel(
            apiService: APIService(),
            favoriteStore: FavouriteStore()
        )
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown(){
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiService = nil
        viewModel = nil
        super.tearDown()
    }

    func testExample() async{
    
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockMopvieService:APIServiceProtocol{
    var shouldThrowError: APIError?
    var mockResponse:Any?
    func fetchMovies<T>() async throws -> T where T : Decodable, T : Encodable {
        if let error = shouldThrowError {
            throw error
        }
        
        guard let response = mockResponse as? T else {
            throw APIError.decodingError
        }
        return response
    }

    
}
