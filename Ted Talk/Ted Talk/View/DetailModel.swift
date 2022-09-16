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
    
    init(_ tedTalk: TedTalk) {
        title = tedTalk.title
        url = tedTalk.url
        views = tedTalk.views
        date = tedTalk.film_date
        name = tedTalk.name
        description = tedTalk.description
        tags = tedTalk.tags
    }
}
