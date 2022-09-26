//
//  DataManagerTest.swift
//  Ted TalkTests
//
//  Created by Agustin Godoy Cosser on 21/09/2022.
//

import XCTest
@testable import Ted_Talk

final class DataManagerTest: XCTestCase {
    
    class MockDelegate: DataManagerDelegate {
        var callBack: ( ([TedTalk]) -> Void )?
        
        func refreshData(_ data: [TedTalk]) {
            callBack?(data)
        }
    }
    
    class MockService: ServiceProtocol {
        var tedTalks: [TedTalk] = [TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1)]
        let toFail: Bool
        
        init(toFail: Bool) {
            self.toFail = toFail
        }
        
        func parseData(_ completionHandler: @escaping (Result<[TedTalk], ServiceError>) -> Void) {
            guard (toFail == false) else {
                completionHandler(.failure(.emptyData))
                return
            }
            completionHandler(.success(tedTalks))
        }
    }
    
    class MockBase: DataBase {
        
        var tedTalks: [TedTalk] = []
        var isEmpty: Bool { return tedTalks.isEmpty }
        
        func persitData(_ data: [TedTalk]) {
            tedTalks = data
        }
        func getData() -> [TedTalk] {
            return tedTalks
        }
        func clearData() {
            tedTalks.removeAll()
        }
    }
    
    var sut: DataManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testGetDataWithEmptyDatabaseAndServiceFailure(){
        sut = DataManager(service: MockService(toFail: true), dataBase: MockBase())
        let promise = self.expectation(description: "Scaling")
        
        sut.getData { result in
            XCTAssertEqual(result.isEmpty, true, "Score computed from guess is wrong")
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func testGetDataWithEmptyDatabaseAndServiceSuccess() {
        sut = DataManager(service: MockService(toFail: false), dataBase: MockBase())
        let promise = self.expectation(description: "Scaling")
        
        sut.getData { result in
            XCTAssertEqual(result.count, 1, "Score computed from guess is wrong")
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        
    }
    
    func testGetDataWithNoEmptyDatabaseAndServiceFailure() {
        let dataBase = MockBase()
        dataBase.tedTalks = [TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1), TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1)]
        sut = DataManager(service: MockService(toFail: true), dataBase: dataBase)
        let promise = self.expectation(description: "Get Data Rensponse")
        
        sut.getData { result in
            XCTAssertEqual(result.count, 2)
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetDataWithNoEmptyDatabaseAndServiceSuccess() {
        let dataBase = MockBase()
        dataBase.tedTalks = [TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1), TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1)]
        sut = DataManager(service: MockService(toFail: false), dataBase: dataBase)
        let delegate = MockDelegate()
        sut.delegate = delegate
        let promise = self.expectation(description: "Get Data Rensponse")
        let servicePromise = self.expectation(description: "Delegate Called")
        
        sut.getData { result in
            XCTAssertEqual(result.count, 2)
            promise.fulfill()
        }
        
        delegate.callBack = { data in
            XCTAssertEqual(data.count, 1)
            servicePromise.fulfill()
        }
        
        wait(for: [promise, servicePromise], timeout: 5)
    }
}
