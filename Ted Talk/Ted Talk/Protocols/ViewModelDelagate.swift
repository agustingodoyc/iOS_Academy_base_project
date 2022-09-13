//
//  ViewModelDelagate.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 09/09/2022.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func loadData()
    func reloadData()
}
