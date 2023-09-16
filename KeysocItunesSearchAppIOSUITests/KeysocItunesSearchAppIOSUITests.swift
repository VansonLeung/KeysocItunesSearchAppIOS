//
//  KeysocItunesSearchAppIOSUITests.swift
//  KeysocItunesSearchAppIOSUITests
//
//  Created by Vanson Leung on 12/9/2023.
//

import XCTest

final class KeysocItunesSearchAppIOSUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testDemo() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.searchFields["Search by keywords"].tap()
        
        app.keys["A"].tap()
        app.keys["l"].tap()
        app.keys["e"].tap()
        app.keys["x"].tap()

        app.buttons["search"].tap()

        let punchBrothersAntifogmaticDeluxeVersionStaticText = app.scrollViews.otherElements.tables.staticTexts["Punch Brothers Antifogmatic (Deluxe Version)"]
        punchBrothersAntifogmaticDeluxeVersionStaticText.tap()

        app.navigationBars["Search"].buttons["Filters"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Select country"].tap()
        tablesQuery.staticTexts["Australia"].tap()
        app.navigationBars["Select country"].buttons["Back"].tap()

        tablesQuery.staticTexts["Podcasts"].tap()
        app.navigationBars["Search"].buttons["Search"].tap()

        app.buttons["Albums"].tap()
        app.buttons["Artists"].tap()
        app.buttons["Albums"].tap()
        app.buttons["Songs"].tap()

                                        
    }

    
    
    func testChangeLanguage() throws {

        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["設定"].exists, "Item not found")
        app.tabBars["Tab Bar"].buttons["設定"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["語言"]/*[[".cells.staticTexts[\"語言\"]",".staticTexts[\"語言\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let staticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["繁體中文"]/*[[".cells.staticTexts[\"繁體中文\"]",".staticTexts[\"繁體中文\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        staticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["English"]/*[[".cells.staticTexts[\"English\"]",".staticTexts[\"English\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Languages"].staticTexts["Languages"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["簡體中文"]/*[[".cells.staticTexts[\"簡體中文\"]",".staticTexts[\"簡體中文\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["语言"].staticTexts["语言"].tap()
        staticText.tap()
        
        let navigationBar = app.navigationBars["語言"]
        navigationBar.staticTexts["語言"].tap()
        navigationBar.buttons["設定"].tap()
        
        
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["設定"].exists, "Item not found")
    }
    
    
    func testSearchAndClick() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.searchFields["關鍵字搜尋"].tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let xKey = app/*@START_MENU_TOKEN@*/.keys["x"]/*[[".keyboards.keys[\"x\"]",".keys[\"x\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        xKey.tap()
        
        app.buttons["Search"].tap()
        
        app.scrollViews.otherElements.tables/*@START_MENU_TOKEN@*/.staticTexts["Punch Brothers Antifogmatic (Deluxe Version)"]/*[[".cells.staticTexts[\"Punch Brothers Antifogmatic (Deluxe Version)\"]",".staticTexts[\"Punch Brothers Antifogmatic (Deluxe Version)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["收藏"].tap()
        app.navigationBars["收藏"].buttons["編輯"].tap()
                
    }
    
    
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
