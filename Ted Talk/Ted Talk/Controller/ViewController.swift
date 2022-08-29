//
//  ViewController.swift
//  Ted Talk
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var data: [TedTalk] = []
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        DataManager().getTalks() { talks in
            self.data = talks
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
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
