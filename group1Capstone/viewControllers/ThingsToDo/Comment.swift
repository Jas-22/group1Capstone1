//
//  Comment.swift
//  group1-capstone-project
//
//  Created by Jose Alberto Martinez Pineda on 2022-08-05.
//

import Foundation
import RealmSwift
import Realm
 

// MARK: - Comment
class Comment: Object {
    @objc dynamic var idUser: String = " "
    @objc dynamic var rate: Double = 0
    @objc dynamic var comment: String = " "
    @objc dynamic var date: String = " "
    
    

    convenience init(idUser: String, rate: Double, comment: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        self.init()
        self.idUser = idUser
        self.rate = rate
        self.comment = comment
        self.date = dateFormatter.string(from: Date())
    }
}
