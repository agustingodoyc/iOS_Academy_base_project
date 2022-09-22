//
//  TedTalkViewModel.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 09/09/2022.
//

import Foundation

class TableViewModel {
    
    // MARK: - Properties
    
    let dataManager: DataManager
    
    weak var delegate: ViewModelDelegate?
    
    var filteredData: [TedTalk] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    var tedTalkData: [TedTalk] = []
    
    var filters: Array<String> {
        return pickerOptions.allCases.map { $0.rawValue }
    }
    
    enum pickerOptions: String, CaseIterable {
        case event = "Event"
        case main_speaker = "Main Speaker"
        case title = "Title"
        case name = "Name"
        case descript = "Description"
    }
    
    init(_ dataManager: DataManager = DataManager()){
        self.dataManager = dataManager
    }
    
    // MARK: - Methods
    
    func updateData() {
        self.dataManager.getData() { result in
                self.delegate?.loadData()
                self.tedTalkData = result
                self.filteredData = result
            }
    }
}

// MARK: - Table View

extension TableViewModel {
    func getNumberOfRows() -> Int {
        return self.filteredData.count
    }
    
    func getTedTalk(_ index: Int) -> TedTalk {
        return filteredData[index]
    }
    
    func getCell(_ index: Int) -> CellModel {
        return .init(getTedTalk(index))
    }
}

// MARK: - Search Bar

extension TableViewModel {
    func filterData(text: String, picker: Int) {
        guard text != "" else {
            filteredData = tedTalkData
            return
        }
        filteredData = tedTalkData.filter { talk in
            switch filters[picker] {
            case "Event":
                return talk.event.lowercased().contains(text.lowercased())
            case "Main Speaker":
                return talk.mainSpeaker.lowercased().contains(text.lowercased())
            case "Title":
                return talk.title.lowercased().contains(text.lowercased())
            case "Name":
                return talk.name.lowercased().contains(text.lowercased())
            case "Description":
                return talk.descript.lowercased().contains(text.lowercased())
            default:
                return [talk.event, talk.mainSpeaker, talk.title, talk.name, talk.descript]
                    .map({ $0.lowercased() }).reduce(false) { $0 || $1.contains(text.lowercased()) }
            }
        }
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
}

// MARK: - Detail View

extension TableViewModel {
    func getDetail(_ index: Int) -> DetailModel {
        return .init(getTedTalk(index))
    }
}

// MARK: - Realm

extension TableViewModel: DataManagerDelegate {
    func refreshData(_ data: [TedTalk]) {
        tedTalkData = data
        filteredData = data
    }
}

