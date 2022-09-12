//
//  TedTalkService.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 07/09/2022.
//

import Foundation

class NSURLSessionParser: ServiceProtocol {
    
    struct Configuration {
        static let urlAsString = "https://gist.githubusercontent.com/gonzaloperretti/0e79c229a5de5bacdd07f402c1a3cefd/raw/975582a4389601caa90d21227446ef2838159176/tedTalks.json"
    }
    
    func getTedTalks(_ completionHandler: @escaping (Result<[TedTalk], ServiceError>) -> Void) {
        let session = URLSession.shared
        let url = URL(string: Configuration.urlAsString)
        
        guard let url = url else {
            return completionHandler(.failure(.badURL))
        }

        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return completionHandler(.failure(.error))
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.emptyData))
            return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([TedTalk].self, from: data)
                completionHandler(.success(dataFromJson))
            }catch {
                completionHandler(.failure(.error))
            }
        }.resume()
    }
    
    
}
