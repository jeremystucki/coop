//
//  UITests.swift
//  UITests
//
//  Created by Jeremy Stucki on 19.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import XCTest
import UIKit

class UITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testExample() {
        let app = XCUIApplication()

        setupSnapshot(app)
        app.launch()

        let tablesQuery = app.tables
        tablesQuery.staticTexts["Aarau"].tap()

        let aarauNavigationBar = app.navigationBars["Aarau"]
        aarauNavigationBar.buttons["empty star"].tap()
        aarauNavigationBar.buttons.element(boundBy: 0).tap()
        tablesQuery.staticTexts["Baden"].tap()

        let badenNavigationBar = app.navigationBars["Baden"]
        badenNavigationBar.buttons["empty star"].tap()
        badenNavigationBar.buttons.element(boundBy: 0).tap()

        snapshot("Favorites")

        XCUIApplication().tables.children(matching: .cell).element(boundBy: 1).tap()

        snapshot("Restaurant")

        XCUIApplication().tables.children(matching: .cell).element(boundBy: 0).tap()

        snapshot("Menu")
    }

}

