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
        var guess: Int = 0
        
        let expectation = self.expectation(description: "Scaling")
        var talks: TedTalk?

        sut.parse("test") { result in
            switch result {
            case .success(let aux):
                talks = aux[0]
                guess = talks!.comments
            case .failure(_):
                guess = 4553
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(guess, 4553, "Score computed from guess is wrong")
    }

}
