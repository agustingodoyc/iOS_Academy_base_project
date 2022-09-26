//
//  DataManagerDelegate.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 20/09/2022.
//

import Foundation

protocol DataManagerDelegate: AnyObject {
    func refreshData(_ data: [TedTalk])
}
