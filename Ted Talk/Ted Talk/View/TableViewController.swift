//
//  ViewController.swift
//  Ted Talk
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - View Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var picker: UIPickerView!
    
    // MARK: - Properties
    
    lazy var viewModel = { TableViewModel() }()
    
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
        activityIndicator.startAnimating()
        viewModel.delegate = self
        viewModel.updateData()
    }
}

// MARK: - Table View
    
extension TableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tedTalkCell",
                                                       for: indexPath) as? CellView else {
            return UITableViewCell()
        }
        
        cell.loadData(viewModel.getCell(indexPath.row))
        return cell
    }
}

//MARK: - Picker View

extension TableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getPickersCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getPicker(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard !(searchBar.text?.isEmpty ?? true) else {
            return
        }
        
        viewModel.filterData(searchText: searchBar.text ?? "", picker: picker.selectedRow(inComponent: 0))
    }
}

// MARK: - Search Bar

extension TableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterData(searchText: searchText, picker: picker.selectedRow(inComponent: 0))
    }
}

// MARK: - Detail View

extension TableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedPath = tableView.indexPathForSelectedRow else {
            return
        }
        if segue.identifier == "detail", let destination = segue.destination as? DetailViewController {
            destination.tedTalk = viewModel.getDetail(selectedPath.row)
        }
    }
}

// MARK: - Delegate

extension TableViewController: ViewModelDelegate {
    func loadData() {
        self.activityIndicator.stopAnimating()
        self.tableView.isHidden = false
        self.searchBar.isHidden = false
        self.picker.isHidden = false
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
