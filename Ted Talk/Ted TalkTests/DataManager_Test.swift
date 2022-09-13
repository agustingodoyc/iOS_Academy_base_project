//
//  DataManager_Test.swift
//  Ted TalkTests
//
//  Created by Agustin Godoy Cosser on 02/09/2022.
//

import XCTest
@testable import Ted_Talk

class DataManager_Test: XCTestCase {

    let sut: DataManager = DataManager("test")
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testSearchWord() {
        let promise = self.expectation(description: "Scaling")
        var talks: [TedTalk]?
        
        sut.getTalks { result in
            talks = result
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        talks = sut.serchWord(searchText: "x", picker: "description")
        
        XCTAssertEqual(talks?.count, 0, "Score computed from guess is wrong")
    }

}
