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
    
    @IBOutlet weak var tedTalkTitle: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Properties
    
    var tedTalk: DetailModel?

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ShowDetail()
        
        guard let myURL = URL(string: tedTalk?.url ?? "") else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    

    // MARK: - Functions
     
     func ShowDetail() {
         guard let tedTalk = tedTalk else {
             return
         }
         tedTalkTitle.text = tedTalk.title
         views.text = "#of views: \(String(tedTalk.views))"
         date.text = "Published date: \(String(tedTalk.date))"
         name.text = (tedTalk.name)
         descript.text = tedTalk.descript
         for _ in tedTalk.tags {
             tags.text = "Tags: \(tedTalk.tags.joined(separator: ", ")) "
         }
     }
}
