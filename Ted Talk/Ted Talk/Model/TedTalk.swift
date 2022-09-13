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

}
