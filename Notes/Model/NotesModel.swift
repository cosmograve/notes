//
//  NotesModel.swift
//  Notes
//
//  Created by Алексей Авер on 04.02.2023.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var text: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var image: Data? = nil
    
    convenience init(text: String, date: Date, imageData: Data?) {
        self.init()
        self.text = text
        self.date = date
        
    }
}

//class Note: Object {
//    @objc dynamic var text = ""
//    @objc dynamic var date: Date?
//    @objc dynamic var imageData: Data?
//
//
//
//}
