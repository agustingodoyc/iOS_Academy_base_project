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
    
    private var file: String
    private var data: [TedTalk]
    
    init (_ file: String = "tedTalks") {
        self.file = file
        data = []
    }
    
    // MARK: Methods
    
    func getTalks(completionHandler: @escaping ([TedTalk]) -> Void){
        Parser().parse(file) { result in
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
    
    func serchWord(searchText: String, picker: String) -> [TedTalk] {
        var filteredData: [TedTalk] = []
        guard searchText != "" else {
            return data
        }
        filteredData = data.filter { talk in
            switch picker {
            case "Event":
                return talk.event.lowercased().contains(searchText.lowercased())
            case "Main Speaker":
                return talk.main_speaker.lowercased().contains(searchText.lowercased())
            case "Title":
                return talk.title.lowercased().contains(searchText.lowercased())
            case "Name":
                return talk.name.lowercased().contains(searchText.lowercased())
            case "Description":
                return talk.description.lowercased().contains(searchText.lowercased())
            default:
                return [talk.event, talk.main_speaker, talk.title, talk.name, talk.description]
                    .map({ $0.lowercased() }).reduce(false) { $0 || $1.contains(searchText.lowercased()) }
            }
        }
        return filteredData
    }
}
