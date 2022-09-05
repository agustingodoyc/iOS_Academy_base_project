//
//  ViewController.swift
//  Ted Talk
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - View Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var picker: UIPickerView!
    
    // MARK: - View Properties
    
    var data: [TedTalk] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let dataManager: DataManager = DataManager()
    
    enum pickerOptions: String, CaseIterable {
        case event = "Event"
        case main_speaker = "Main Speaker"
        case title = "Title"
        case name = "Name"
        case description = "Description"
    }
    
    var filters: Array<String> {
        return pickerOptions.allCases.map { $0.rawValue }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        picker.isHidden = true
        searchBar.isHidden = true
        picker.dataSource = self
        picker.delegate = self
        searchBar.delegate = self
        activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        
        dataManager.getTalks() { talks in
            self.data = talks
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.searchBar.isHidden = false
                self.picker.isHidden = false
            }
        }
    }
}

// MARK: - Table View
    
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tedTalkCell",
                                                       for: indexPath) as? TedTalkCell else {
            return UITableViewCell()
        }
        
        cell.loadData(.init(talk: data[indexPath.row]))
        return cell
    }
}

//MARK: - Picker View

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filters[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard !(searchBar.text?.isEmpty ?? true) else {
            return
        }
        
        data = dataManager.serchWord(searchText: searchBar.text ?? "", picker: filters[picker.selectedRow(inComponent: 0)])
    }
}

// MARK: - Search Bar

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = dataManager.serchWord(searchText: searchText, picker: filters[picker.selectedRow(inComponent: 0)])
    }
}
