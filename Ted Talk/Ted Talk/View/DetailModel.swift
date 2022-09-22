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
    let descript: String
    let tags: [String]
    
    init(_ tedTalk: TedTalk) {
        title = tedTalk.title
        url = tedTalk.url
        views = tedTalk.views
        date = tedTalk.filmDate
        name = tedTalk.name
        descript = tedTalk.descript
        tags = Array(tedTalk.tags)
    }
}
