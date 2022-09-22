//
//  RealmDB.swift
//  Ted Talk
//
//  Created by Agustin Godoy Cosser on 16/09/2022.
//

import Foundation
import RealmSwift

class RealmDB: DataBase {
    
    private var realm: Realm
    var isEmpty: Bool { return realm.isEmpty}
    
    required init(){
        do {
            self.realm = try Realm()
        } catch {
            print("Error \(error)")
            fatalError("Unable to create an Realm instance")
        }
    }
    
    func persitData(_ data: [TedTalk]) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
            return
        }
    }
    
    func getRealmData() -> [TedTalk] {
        return Array(self.realm.objects(TedTalk.self))
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
