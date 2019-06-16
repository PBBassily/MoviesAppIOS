//
//  MovieCreationTesting.swift
//  MoviesAppTests
//
//  Created by Paula Boules on 6/16/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import XCTest


class MovieCreationTesting: XCTestCase {
    
    var viewModel: MovieCreationViewModel!
    override func setUp() {
        viewModel = MovieCreationViewModel()
    }
    
    func testEmptyAllFields() {
        viewModel.poster = nil
        viewModel.title  = ""
        viewModel.overview = ""
        viewModel.dateRawString = ""
        XCTAssertEqual(viewModel.shouldSave, false, "invalid save operation")
    }
    
    func testEmptyTitleField() {
        viewModel.poster = nil
        viewModel.title  = ""
        viewModel.overview = "Overview"
        viewModel.dateRawString = "22/4/2001"
        XCTAssertEqual(viewModel.shouldSave, false, "invalid save operation: no title")
    }
    
    func testEmptyOverviewField() {
        viewModel.poster = nil
        viewModel.title  = "Title"
        viewModel.overview = "Overview"
        viewModel.dateRawString = ""
        XCTAssertEqual(viewModel.shouldSave, false, "invalid save operation: no overview")
    }
    
    func testEmptyDateField() {
        viewModel.poster = nil
        viewModel.title  = "Title"
        viewModel.overview = "Overview"
        viewModel.dateRawString = ""
        XCTAssertEqual(viewModel.shouldSave, false, "invalid save operation: no date")
    }
    
    func testInvalidDate() {
        viewModel.poster = nil
        viewModel.title  = "Title"
        viewModel.overview = "Overview"
        viewModel.dateRawString = "012893297483742975889475489357"
        XCTAssertEqual(viewModel.shouldSave, false, "invalid save operation: invalid date")
    }
    
    func testValidDate() {
        viewModel.poster = nil
        viewModel.title  = "Title"
        viewModel.overview = "Overview"
        viewModel.dateRawString = "22/2/2001"
        XCTAssertEqual(viewModel.shouldSave, true, "valid save operation")
    }
    
    func testMovieFieldsAreTheSameWeCreated() {
        viewModel.poster = UIImage(named: "poster_placeholder")
        viewModel.title  = "Title"
        viewModel.overview = "Overview"
        viewModel.dateRawString = "22/2/2001"
        let movie = viewModel.getMovie()
        XCTAssertEqual(movie.title, "Title", "bad title")
        XCTAssertEqual(movie.overview, "Overview", "bad overview")
        XCTAssertEqual(movie.poster, UIImage(named: "poster_placeholder"), "bad poster")
        XCTAssertEqual(movie.hasPoster, true, "the movie has already a poster")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        XCTAssertEqual(movie.date, formatter.date(from: "22/2/2001"), "bad date")
    }
}
