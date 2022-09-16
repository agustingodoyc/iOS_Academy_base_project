//
//  TableViewModelTest.swift
//  Ted TalkTests
//
//  Created by Agustin Godoy Cosser on 02/09/2022.
//
import XCTest
@testable import Ted_Talk

class TableViewModelTest: XCTestCase {

    struct MockService: ServiceProtocol {
        var talks: [TedTalk] = [TedTalk(comments: 1, description: "Description", duration: 1, event: "Event", film_date: 1, languages: 1, main_speaker: "Main Speaker", name: "Name", num_speaker: 1, published_date: 1, speaker_occupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1)]
        
        func getTedTalks(_ completionHandler: @escaping (Result<[Ted_Talk.TedTalk], Ted_Talk.ServiceError>) -> Void) {
            completionHandler(.success(talks))
        }
    }
    
    let sut: TableViewModel = TableViewModel(DataManager(MockService()))
    
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
