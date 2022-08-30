//
//  DataManager.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 25/08/2022.
//

import Foundation

public class DataManager {
    
    private var file: String
    
    init (file: String = "tedTalks") {
        self.file = file
    }
    
    func getTalks(completionHandler: @escaping ([TedTalk]) -> Void){
        Parser().parse(file) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completionHandler(data)
                case .failure(_):
                    completionHandler([])
                }
            }
        }
    }
}
