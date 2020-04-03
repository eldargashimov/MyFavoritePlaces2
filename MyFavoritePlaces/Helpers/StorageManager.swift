//
//  StorageManager.swift
//  MyFavoritePlaces
//
//  Created by Mac on 25.03.2020.
//  Copyright © 2020 Eldar Gashimov. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Place) {
        
        try! realm.write {
            realm.delete(place)
        }
    }
}
