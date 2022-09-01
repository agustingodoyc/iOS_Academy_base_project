//
//  Ted_TalkTests.swift
//  Ted TalkTests
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import XCTest
@testable import Ted_Talk

class Ted_TalkTests: XCTestCase {
    
    // MARK: - Test init
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Test parse

    func testParse() {
        let sut: Parser = Parser()
        let promise = self.expectation(description: "Scaling")
        var talks: [TedTalk]?

        sut.parse("test") { result in
            switch result {
            case .success(let aux):
                talks = aux
            case .failure(_):
                XCTFail()
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(talks![0].comments, 4553, "Score computed from guess is wrong")
        XCTAssertEqual(talks![0].tags[0], "children", "Score computed from guess is wrong")
        XCTAssertEqual(talks!.count, 1, "Score computed from guess is wrong")
    }

    func  testParseToFail() {
        let sut: Parser = Parser()
        let promise = self.expectation(description: "Scaling")

        sut.parse("xxxx") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test searchWord
    
    func testSearchWord() {
        let sut: DataManager = DataManager("test")
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
