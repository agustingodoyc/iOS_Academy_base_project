//
//  Ted_TalkTests.swift
//  Ted TalkTests
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import XCTest
@testable import Ted_Talk

class Ted_TalkTests: XCTestCase {
    
    var sut: Parser!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Parser()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testParse() {
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
}
