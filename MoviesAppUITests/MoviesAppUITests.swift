//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import XCTest

class MoviesAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launch()
    }
    
    func testFirstTableView() {
        XCTAssertEqual(app.tables["MoviesListTableView"].exists, true)
        XCTAssertEqual(app.cells["MovieTableViewCell"].exists, true)
    }
    
    func testMoviesCellsStruture() {
        XCTAssertEqual(app.tables["MoviesListTableView"].cells.element(boundBy: 0).staticTexts.count, 3)
        XCTAssertEqual(app.tables["MoviesListTableView"].cells.element(boundBy: 0).images.count, 1)
    }
    
    func testCreateMovie() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertEqual(app.images["MoviePosterImageView"].exists, true)
        XCTAssertEqual(app.textFields["MovieTitleField"].exists, true)
        XCTAssertEqual(app.textFields["MovieDateField"].exists, true)
        XCTAssertEqual(app.textViews["MovieOverviewTextView"].exists, true)
        XCTAssertEqual(app.buttons["MovieSaveButton"].exists, true)
    }
}
