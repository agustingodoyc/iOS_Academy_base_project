//
//  ViewController.swift
//  Ted Talk
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    var data: [TedTalk] = []
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        DataManager().getTalks() { talks in
            self.data = talks
            self.activityIndicator.stopAnimating()
        }
    }
}
