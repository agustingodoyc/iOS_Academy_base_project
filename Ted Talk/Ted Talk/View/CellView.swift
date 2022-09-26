//
//  Cell.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 29/08/2022.
//

import Foundation
import UIKit

class CellView: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descript: UILabel!
    
    func loadData(_ tedTalk: CellModel){
        name.text = tedTalk.name
        descript.text = tedTalk.descript
    }
    
}
