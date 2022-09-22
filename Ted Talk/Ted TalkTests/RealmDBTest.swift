//
//  RealmDBTest.swift
//  Ted TalkTests
//
//  Created by Agustin Godoy Cosser on 22/09/2022.
//

import XCTest
@testable import Ted_Talk

final class RealmDBTest: XCTestCase {
    
    var sut = RealmDB()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testPersitData() {
        sut.persitData([TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1), TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1)])
        
        XCTAssertEqual(sut.isEmpty, false)
    }
    
    func testGetRealmData() {
        sut.persitData([TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1), TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1)])
        XCTAssertEqual(sut.getRealmData().count, 2)
    }
    
    func testClearData() {
        sut.persitData([TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1), TedTalk(comments: 1, descript: "Description", duration: 1, event: "Event", filmDate: 1, languages: 1, mainSpeaker: "Main Speaker", name: "Name", numSpeaker: 1, publishedDate: 1, speakerOccupation: "Speaker Occupation", tags: ["tag"], title: "Title", url: "URL", views: 1)])
        sut.clearData()
        XCTAssertEqual(sut.isEmpty, true)
    }
}
