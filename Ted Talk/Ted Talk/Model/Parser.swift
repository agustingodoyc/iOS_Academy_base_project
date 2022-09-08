//
//  DataLoader.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 22/08/2022.
//

import Foundation
import UIKit

public class Parser: ServiceProtocol {
    
    private var file: String
    //private var service: ServiceProtocol
    
    init (_ file: String = "tedTalks") {
        self.file = file
    }
    
    func getTedTalks(_ completionHandler: @escaping (Result<[TedTalk], ServiceError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let fileLocation = Bundle.main.url(forResource: self.file, withExtension: "json") else {
                completionHandler(.failure(.fileNotFound))
                return
            }
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([TedTalk].self, from: data)
                completionHandler(.success(dataFromJson))
            } catch {
                completionHandler(.failure(.parseError))
            }
        }
    }
 }
