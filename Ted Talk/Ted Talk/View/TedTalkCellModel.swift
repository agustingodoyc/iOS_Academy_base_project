//
//  TedTalkCellModel.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 29/08/2022.
//

import Foundation

struct TedTalkCellModel {
    let name: String
    let description: String
    
    init (talk: TedTalk) {
        name = talk.name
        description = talk.description
    }
}
