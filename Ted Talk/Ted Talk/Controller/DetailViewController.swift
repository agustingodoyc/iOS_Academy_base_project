//
//  DetailViewController.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 05/09/2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
    
    // MARK: - Outles
    
    @IBOutlet weak var talkTitle: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Properties
    
    var talk: DetailModel?

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ShowDetail()
        
        guard let myURL = URL(string: talk?.url ?? "") else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    

    // MARK: - Functions
     
     func ShowDetail() {
         guard let talk = talk else {
             return
         }
         talkTitle.text = talk.title
         views.text = "#of views: \(String(talk.views))"
         date.text = "Published date: \(String(talk.date))"
         name.text = (talk.name)
         desc.text = talk.description
         for _ in talk.tags {
             tags.text = "Tags: \(talk.tags.joined(separator: ", ")) "
         }
     }
}
