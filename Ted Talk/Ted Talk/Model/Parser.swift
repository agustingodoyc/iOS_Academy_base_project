//
//  DataLoader.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 22/08/2022.
//

import Foundation
import UIKit

public class Parser: ServiceProtocol {
    
    // MARK: - Properties
    
    private var fileName: String
    
    init (_ fileName: String = "tedTalks") {
        self.fileName = fileName
    }
    
    // MARK: - Methods
    
    func parseData(_ completionHandler: @escaping (Result<[TedTalk], ServiceError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let fileLocation = Bundle.main.url(forResource: self.fileName, withExtension: "json") else {
                return completionHandler(.failure(.fileNotFound))
            }
            do {
                let jsonData = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([TedTalk].self, from: jsonData)
                completionHandler(.success(dataFromJson))
            } catch {
                completionHandler(.failure(.parseError))
            }
        }
    }
 }
