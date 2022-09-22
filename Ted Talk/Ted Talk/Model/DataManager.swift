//
//  DataManager.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 25/08/2022.
//

import Foundation
import UIKit
import RealmSwift

public class DataManager {
    
    // MARK: - Properties
    
    private var service: ServiceProtocol
    weak var delegate: DataManagerDelegate?
    var dataBase: DataBase
    
    init (service: ServiceProtocol = NSURLSessionParser(), dataBase: DataBase = RealmDB()){
        self.service = service
        self.dataBase = dataBase
    }
    
    // MARK: - Methods
    
    func getData(completionHandler: @escaping ([TedTalk]) -> Void){
        if (dataBase.isEmpty){
            service.getTedTalks() { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.dataBase.persitData(data)
                        completionHandler(data)
                    case .failure(_):
                        completionHandler([])
                    }
                }
            }
        } else {
            completionHandler(dataBase.getRealmData())
            service.getTedTalks() { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.dataBase.clearData()
                        self.dataBase.persitData(data)
                        self.delegate?.refreshData(data)
                    case .failure(_):
                        break
                    }
                }
            }
        }
    }
}
