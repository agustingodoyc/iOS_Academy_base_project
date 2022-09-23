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
    weak var delegate: DataManagerDelegate?
    private var dataBase: DataBase
    
    init (service: ServiceProtocol = NSURLSessionParser(), dataBase: DataBase = RealmDB()){
        self.service = service
        self.dataBase = dataBase
    }
    
    // MARK: - Methods
    
    func getData(completionHandler: @escaping ([TedTalk]) -> Void) {
        if (dataBase.isEmpty) {
            service.parseData() { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let tedTalks):
                        self.dataBase.persitData(tedTalks)
                        completionHandler(tedTalks)
                    case .failure(_):
                        completionHandler([])
                    }
                }
            }
        } else {
            completionHandler(dataBase.getData())
            service.parseData() { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.dataBase.clearData()
                        self.dataBase.persitData(data)
                        self.delegate?.refreshData(data)
                    case .failure(_):
                        return
                    }
                }
            }
        }
    }
}
