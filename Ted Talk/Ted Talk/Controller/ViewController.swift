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
        // To hide the Indicator at lunch
        activityIndicator.hidesWhenStopped = true
        // Do any additional setup after loading the view.
        let file = "tedTalks"
        self.activityIndicator.startAnimating()
        Parser().parse(file) { result in
            switch result {
            case .success(let data):
                self.data = data
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

