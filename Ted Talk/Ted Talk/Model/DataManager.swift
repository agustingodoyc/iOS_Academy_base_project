//
//  DataManager.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 25/08/2022.
//

import Foundation
import UIKit

public class DataManager {
    
    // MARK: - Properties
    
    private var service: ServiceProtocol
    
    init (_ service: ServiceProtocol = NSURLSessionParser()){
        self.service = service
    }
    
    // MARK: - Methods
    
    func getData(completionHandler: @escaping ([TedTalk]) -> Void){
        service.getTedTalks() { result in
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
