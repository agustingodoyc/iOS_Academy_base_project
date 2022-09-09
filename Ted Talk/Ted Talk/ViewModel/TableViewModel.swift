//
//  TedTalkViewModel.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 09/09/2022.
//

import Foundation

class TableViewModel {
    
    // MARK: - Properties
    
    let dataManager: DataManager = DataManager()
    
    var delegate: ViewModelDelegate?
    
    var data: [TedTalk] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    var filters: Array<String> {
        return pickerOptions.allCases.map { $0.rawValue }
    }
    
    enum pickerOptions: String, CaseIterable {
        case event = "Event"
        case main_speaker = "Main Speaker"
        case title = "Title"
        case name = "Name"
        case description = "Description"
    }
    
    // MARK: - Methods
    
    func updateData() {
        dataManager.getData() { result in
            self.delegate?.loadData()
            self.data = result
        }
    }
}

// MARK: - Table View

extension TableViewModel {
    func getDataRows() -> Int {
        return self.data.count
    }
    
    func getCell(_ index: Int) -> TedTalk {
        return data[index]
    }
}

// MARK: - Picker View

extension TableViewModel {
    func getPickersCount() -> Int{
        return pickerOptions.allCases.count
    }
    
    func getPicker(_ row: Int) -> String? {
        return pickerOptions.allCases[row].rawValue
    }
    
    func filterData(searchText: String, picker: Int) {
        data = dataManager.filterByText(text: searchText, picker: filters[picker])
    }
}

