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
    private var data: [TedTalk]
    
    init (_ service: ServiceProtocol = FromWebParser()){
        self.service = service
        self.data = []
    }
    
    // MARK: - Methods
    
    func getData(completionHandler: @escaping ([TedTalk]) -> Void){
        service.getTedTalks() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completionHandler(data)
                    self.data = data
                case .failure(_):
                    completionHandler([])
                }
            }
        }
    }
    
    func filterByText(text: String, picker: String) -> [TedTalk] {
        var filteredData: [TedTalk] = []
        guard text != "" else {
            return data
        }
        filteredData = data.filter { talk in
            switch picker {
            case "Event":
                return talk.event.lowercased().contains(text.lowercased())
            case "Main Speaker":
                return talk.main_speaker.lowercased().contains(text.lowercased())
            case "Title":
                return talk.title.lowercased().contains(text.lowercased())
            case "Name":
                return talk.name.lowercased().contains(text.lowercased())
            case "Description":
                return talk.description.lowercased().contains(text.lowercased())
            default:
                return [talk.event, talk.main_speaker, talk.title, talk.name, talk.description]
                    .map({ $0.lowercased() }).reduce(false) { $0 || $1.contains(text.lowercased()) }
            }
        }
        return filteredData
    }
}
