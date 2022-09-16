//
//  TedTalk.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 22/08/2022.
//

import Foundation

struct TedTalk: Codable {
    
    var comments: Int
    var description: String
    var duration: Int
    var event: String
    var film_date: Int
    var languages: Int
    var main_speaker : String
    var name: String
    var num_speaker: Int
    var published_date: Int
    var speaker_occupation: String
    var tags: [String]
    var title: String
    var url: String
    var views: Int
    
    init(comments: Int, description: String, duration: Int, event: String, film_date: Int, languages: Int, main_speaker: String, name: String, num_speaker: Int, published_date: Int, speaker_occupation: String, tags: [String], title: String, url: String, views: Int) {
        self.comments = comments
        self.description = description
        self.duration = duration
        self.event = event
        self.film_date = film_date
        self.languages = languages
        self.main_speaker = main_speaker
        self.name = name
        self.num_speaker = num_speaker
        self.published_date = published_date
        self.speaker_occupation = speaker_occupation
        self.tags = tags
        self.title = title
        self.url = url
        self.views = views
    }

}
