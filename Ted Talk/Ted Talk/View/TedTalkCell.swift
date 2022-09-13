//
//  Cell.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 29/08/2022.
//

import Foundation
import UIKit

class TedTalkCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    func loadData(_ tedTalk: TedTalkCellModel){
        name.text = tedTalk.name
        desc.text = tedTalk.description
    }
    
}
