//
//  NotesManager.swift
//  Notes
//
//  Created by Алексей Авер on 04.02.2023.
//

import RealmSwift
import Foundation

let realm = try! Realm()

class NoteManager {
       
    static func saveObject (_ note: Note){
        try! realm.write {
            realm.add(note)
        }
    }
    
    static func updateObject(note: Note, text: String, date: Date, imageData: Data?) {
        try! realm.write {
            note.text = text
            note.date = date
            note.image = imageData
        }
    }
    
    static func deleteObject(_ note: Note){
        try! realm.write {
            realm.delete(note)
        }
    }
}

