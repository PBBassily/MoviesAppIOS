//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import XCTest
@testable import MoviesApp

class MoviesListTesting: XCTestCase {
    var viewModel: MoviesListViewModel!
    var model: MoviesListModel!
    let PAGE_SIZE = 20
    let TIMEOUT: TimeInterval = 10
    
    override func setUp() {
        viewModel = MoviesListViewModel()
        model = MoviesListModel()
    }
    
    func testEmptyDataSourceAFterInit() {
        XCTAssertEqual(viewModel.getNumberOfMovies(at: .allMovies), 0, "bad number of all movies")
        XCTAssertEqual(viewModel.getNumberOfMovies(at: .myMovies), 0, "bad number of my movies")
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(viewModel.getNumberOfSections(), 2, "bad number of sections")
    }
    
    func testOnePageOfMovies() {
        let promise = expectation(description: "Completion handler invoked")
        viewModel.updateMoviesList = {
            promise.fulfill()
        }
        viewModel.requestMovies()
        self.wait(for: [promise], timeout: TIMEOUT)
        XCTAssertEqual(viewModel.getNumberOfMovies(at: .allMovies), PAGE_SIZE)
        XCTAssertEqual(viewModel.lastMovieIndex, PAGE_SIZE - 1)
        
    }
    
    func testTenPagesFromTheModel() {
        var promises =  [XCTestExpectation]()
        var errors = [Error?]()
        for i in 1...10 {
            promises.append(expectation(description: "Completion handler invoked of page \(i)"))
            model.getMovies(at: i) { error, _ in
                errors.append(error)
                promises[i-1].fulfill()
            }
        }
        wait(for: promises, timeout: 10 * TIMEOUT)
        XCTAssertEqual(errors.filter({$0 != nil}).count, 0, "erros returned, bad model or APIClient")
    }
    
    func testPagesOutTheBoundFromTheModel() {
        var promise = expectation(description: "Completion handler invoked")
        var requestError: Error?
        model.getMovies(at: 0) { error, _ in
            requestError = error
            promise.fulfill()
        }
        wait(for: [promise], timeout: TIMEOUT)
        XCTAssertEqual(requestError != nil, true, "error should be returned, bad model or APIClient")
        promise = expectation(description: "Completion handler invoked")
        requestError =  nil
        model.getMovies(at: 1001) { error, _ in
            requestError = error
            promise.fulfill()
        }
        wait(for: [promise], timeout: TIMEOUT)
        XCTAssertEqual(requestError != nil, true, "error should be returned, bad model or APIClient")
    }
    
    func testDownloadImage() {
        let promise = expectation(description: "Completion handler invoked")
        var movie = Movie(id: 420817, title: "Aladin", overview: "alajdhjhd", dateRaw: "2019-05-22", posterUrl:  "/3iYQTLGoy7QnjcUYRJy4YrAgGvp.jpg")
        model.downloadImage(for: movie, width: 300) {  image in
            movie.poster = image
            promise.fulfill()
        }
        wait(for: [promise], timeout: TIMEOUT)
        XCTAssertEqual(movie.hasPoster, true, "poster did not attatch to the movie")
        XCTAssertEqual(movie.poster?.size.width, 300, "the downloaded image did not meet width requirement")
        
    }
    
}
