//
//  DataLoader.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 22/08/2022.
//

import Foundation
import UIKit

public class Parser {
    
    enum ParseError: Error {
        case fileNotFound
        case decodeError
    }
    
    func parse(_ file: String, completionHandler: @escaping (Result<[TedTalk], ParseError>) -> Void){
        DispatchQueue.global(qos: .background).async {
            guard let fileLocation = Bundle.main.url(forResource: file, withExtension: "json") else {
                completionHandler(.failure(.fileNotFound))
                return
            }
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([TedTalk].self, from: data)
                completionHandler(.success(dataFromJson))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }
    }
 }
