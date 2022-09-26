//
//  RealmDB.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 16/09/2022.
//

import Foundation
import RealmSwift

class RealmDB: DataBase {
    
    private let realm: Realm
    var isEmpty: Bool { return realm.isEmpty }
    
    init(){
        do {
            realm = try Realm()
        } catch {
            print("Error \(error)")
            fatalError("Unable to create an Realm instance")
        }
    }
    
    func persitData(_ tedTalks: [TedTalk]) {
        do {
            try realm.write {
                realm.add(tedTalks)
            }
        } catch {
            print(error)
            return
        }
    }
    
    func getData() -> [TedTalk] {
        return Array(realm.objects(TedTalk.self))
    }
    
    func clearData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
            return
        }
    }
}
