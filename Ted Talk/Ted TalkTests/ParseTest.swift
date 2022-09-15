//
//  Parse_Test.swift
//  Ted TalkTests
//
//  Created by Agustin Godoy Cosser on 02/09/2022.
//
import XCTest
@testable import Ted_Talk

class ParseTest: XCTestCase {

    var sut: Parser!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testParse() {
        let promise = self.expectation(description: "Scaling")
        var talks: [TedTalk]?
        sut = Parser("test")
        sut.getTedTalks() { result in
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
        sut = Parser("xxxx")
        sut.getTedTalks() { result in
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
