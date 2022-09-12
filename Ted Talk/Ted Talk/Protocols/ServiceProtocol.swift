//
//  ServiceProtocol.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 07/09/2022.
//

import Foundation

enum ServiceError: Error {
    case emptyData
    case parseError
    case serverError
    case clientError
    case badURL
    case error
    case fileNotFound
}

protocol ServiceProtocol {
    func getTedTalks(_ completionHandler: @escaping (Result<[TedTalk], ServiceError>) -> Void)
}
