//
//  DataBase.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 16/09/2022.
//

import Foundation

protocol DataBase {
    var isEmpty: Bool { get }
    func persitData(_ data: [TedTalk])
    func getRealmData() -> [TedTalk]
    func clearData()
}
