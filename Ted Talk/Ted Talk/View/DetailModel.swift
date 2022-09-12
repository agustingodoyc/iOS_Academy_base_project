//
//  DetailModel.swift
//  Ted Talk
//
//  Created by Angela Lee on 02/09/2022.
//
import Foundation

struct DetailModel {
    let title: String
    let url: String
    let views: Int
    let date: Int
    let name: String
    let description: String
    let tags: [String]
    
    init(talk: TedTalk) {
        title = talk.title
        url = talk.url
        views = talk.views
        date = talk.film_date
        name = talk.name
        description = talk.description
        tags = talk.tags
    }
}
