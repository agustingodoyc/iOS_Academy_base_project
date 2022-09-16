//
//  TedTalkCellModel.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 29/08/2022.
//

import Foundation

struct CellModel {
    let name: String
    let description: String
    
    init (_ tedTalk: TedTalk) {
        name = tedTalk.name
        description = tedTalk.description
    }
}
