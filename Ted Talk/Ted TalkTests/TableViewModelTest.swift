//
//  TableViewModelTest.swift
//  Ted TalkTests
//
//  Created by Agustin Godoy Cosser on 02/09/2022.
//
import XCTest
@testable import Ted_Talk

class TableViewModelTest: XCTestCase {

    let sut: TableViewModel = TableViewModel(DataManager(Parser("test")))
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testSearchWord() {
        let promise = self.expectation(description: "Scaling")
        var talks: [TedTalk]?
        
        sut.dataManager.getData { result in
            talks = result
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        sut.filterData(text: "x", picker: 1)
        
        talks = sut.filteredData
        
        XCTAssertEqual(talks?.count, 0, "Score computed from guess is wrong")
    }
}
