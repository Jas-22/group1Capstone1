//
//  ThingStruct.swift
//  group1-capstone-project
//
//  Created by user206772 on 8/8/22.
//

import Foundation


struct ThingsStruct : Codable {
    let data: [ThingStruct]
}


struct ThingStruct : Codable {
    
    var id  : Int
    var nameOfThing : String
    var thingDescription : String
    var address : String
    var hours : String
    var image  : String
    var rate : Double
    var review : Int
    var Phone : String
    var Province : String
    var Area : String
    var latitude : String
    var longitude: String
    var category: String
    var comments: [CommentStruct]
}

struct CommentStruct : Codable {
    
    
    var idUser : String
    var rate : Double
    var comment : String
    var date : String
    
}
