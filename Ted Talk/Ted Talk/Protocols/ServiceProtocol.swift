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
    case dataTaskError
    case fileNotFound
    case decoderError
}

protocol ServiceProtocol {
    func parseData(_ completionHandler: @escaping (Result<[TedTalk], ServiceError>) -> Void)
}
