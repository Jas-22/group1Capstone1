//
//  Thing.swift
//  group1-capstone-project
//
//  Created by Jose Alberto Martinez Pineda on 2022-08-05.
//

 
import RealmSwift
import Realm
import Foundation


class Thing: Object {
    @Persisted var id  : Int
    @Persisted var nameOfThing : String
    @Persisted var thingDescription : String
    @Persisted var address : String
    @Persisted var hours : String

    @Persisted var image  : String
    @Persisted var rate : Double
    @Persisted var review : Int
    @Persisted var Phone : String
    @Persisted var Province : String
    @Persisted var Area : String
    @Persisted var latitude : String
    @Persisted var longitude: String
    @Persisted var category: String
    
    @Persisted var comments: List<Comment>
    
   
}
