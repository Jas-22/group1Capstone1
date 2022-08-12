//
//  DataBase.swift
//  realmDemo
//
//  Created by user206772 on 8/2/22.
//

import Foundation
import RealmSwift
import Realm



func fillDataBase() {
    var config = Realm.Configuration()
   
    config.deleteRealmIfMigrationNeeded = true
    Realm.Configuration.defaultConfiguration = Realm.Configuration(
    
        schemaVersion: 0 ,
        migrationBlock: {migartion,oldschemaVersion in},deleteRealmIfMigrationNeeded: true
    
    )
    let realm = try! Realm()
     let comment = Comment(idUser: "2", rate: 5, comment: "Nice Place")
      
     var  comments = [Comment]()
     
     
      
      //print(comments)
     var things = [Thing]()
    
    var thing = Thing()
    //Victoria Park
    thing.id = 1
    thing.address = "32 Dill St, Kitchener,ON N2G 1L1"
    thing.hours = "6:00 a.m - 11:00 p.m"
    thing.nameOfThing = "Victoria Park"
    thing.rate = 4.6
    thing.review = 6239
    thing.Phone = "(519) 741-2200"
    thing.Area = "24 ha"
    thing.Province = "Ontario"
    
    thing.thingDescription = "Victoria Park is the oldest park in Kitchener, Ontario, Canada, situated downtown. It is the site of numerous events and festivities. A Berlin map from 1879 has a Town Park, located between Mill Street and Highland Road where Highland Courts and Woodside Parks stand today"
    thing.image = "https://explorewaterloo.ca/wp-content/uploads/2016/05/634934229160581495_Final.jpg"
    thing.latitude="43.44569481554042"
    thing.longitude="-80.49827182397819"
    thing.category = "Park & Trails"
    things.append(thing)
    
    
  
    //Waterloo Park
    thing = Thing()
    thing.id = 2
    thing.address = "3100 Father David Bauer Dr, Waterloo, ON N2L 2Y4"
    thing.hours = "7:00 a.m - 11:00 p.m"
    thing.nameOfThing = "Waterloo Park"
    thing.rate = 4.6
    thing.review = 4503
    thing.Phone = "(519) 725-0511"
    thing.Area = "111 acres"
    thing.Province = "Ontario"
    thing.latitude = "43.465735663526885"
    thing.longitude = "-80.53357924490109"
    thing.thingDescription = "Waterloo Park is an urban park situated in Waterloo, Ontario, Canada on land within Block 2 of the Haldimand Tract. Spanning 111 acres within the Uptown area of Waterloo, it opened in 1893 and is the oldest park in the city."
    thing.image = "https://explorewaterloo.ca/wp-content/uploads/2016/05/Waterloo-Park.jpg"
    
    thing.category = "Park & Trails"
   
    thing.comments.append(objectsIn: [comment,comment])
    
    things.append(thing)
    
    
    //Victoria Park
    thing = Thing()
    thing.id = 3
    thing.address = "10 King St W, Kitchener, ON N2G 1A3"
    thing.hours = "10:00 a.m - 4:00 p.m"
    thing.nameOfThing = "THEMUSEUM"
    thing.rate = 4
    thing.review = 1168
    thing.Phone = "(519) 749-9387"
    thing.Area = ""
    thing.Province = "Ontario"
    
    thing.thingDescription = "TheMuseum is an art and technology museum in Kitchener, Ontario, which was opened to the public in September 2003 following eight years of planning and fundraising. TheMuseum, as it was renamed in 2010, offers a range of permanent interactive exhibits and rotating temporary exhibits designed for all ages. "
    thing.image = "https://explorewaterloo.ca/wp-content/uploads/2016/05/THEMUSEUM-602x600.jpg"
    thing.latitude="43.4501"
    thing.longitude="-80.4894"
    thing.category = "Attractions & Entertainment,Museums & Galleries"
    things.append(thing)
    
    
    
    
    
    
    let  resultc = realm.objects(Thing.self)
    
    try! realm.write {
      realm.deleteAll()
    }
    try! realm.write{
        realm.add(things)
    }
    
    
    
}

    func getThing(idThing : Int)-> Thing {
        let realm = try! Realm()
        let things = realm.objects(Thing.self)
            .filter("id = %@", idThing)
        
        return things.first!
    }


    func addComment(idThing : Int,  comment: Comment){
        
        
        let realm = try! Realm()
        let things = realm.objects(Thing.self)
            .filter("id = %@", idThing)
     
        if let thing = things.first{
            
            try! realm.write {
                thing.comments.append(comment)
                let rates = thing.comments.map( {$0.rate }).reduce(0, +)
                thing.review += 1
                thing.rate =  Double(round(100*(rates/Double(thing.comments.count)))/100)
            }
        }
    
        
   
     
 }

func readLocalFile(forName name: String) -> Data? {
do {
   if let bundlePath = Bundle.main.path(forResource: name,
                                        ofType: "json"),
       let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
       return jsonData
   }
} catch {
   print(error)
}

return nil
}

func parse(jsonData: Data) {
do {
   let decodedData = try JSONDecoder().decode(ThingsStruct.self,
                                              from: jsonData)
  
   if decodedData != nil {
    var config = Realm.Configuration()
   
    config.deleteRealmIfMigrationNeeded = true
    Realm.Configuration.defaultConfiguration = Realm.Configuration(
    
        schemaVersion: 0 ,
        migrationBlock: {migartion,oldschemaVersion in},deleteRealmIfMigrationNeeded: true
    
    )
    let realm = try! Realm()
    var things = [Thing]()
    for thingStruct in decodedData.data {
        
        let thing = Thing()
        thing.Area = thingStruct.Area
        thing.Phone = thingStruct.Phone
        thing.Province = thingStruct.Province
        thing.address = thingStruct.address
        thing.category = thingStruct.category
        thing.hours = thingStruct.hours
        thing.id = thingStruct.id
        thing.image = thingStruct.image
        thing.latitude = thingStruct.latitude
        thing.longitude = thingStruct.longitude
        thing.nameOfThing = thingStruct.nameOfThing
        thing.review = thingStruct.review
        thing.rate = thingStruct.rate
        thing.thingDescription = thingStruct.thingDescription
        for comment in thingStruct.comments
        {
            let comment2 = Comment()
            comment2.idUser = comment.idUser
            comment2.date = comment.date
            comment2.rate = comment.rate
            comment2.comment = comment.comment
            
            
            print("Comment: \(comment2.idUser)")
            thing.comments.append(comment2)
        }
        
        things.append(thing)
        
    }
    let  resultc = realm.objects(Thing.self)
    
    try! realm.write {
      realm.deleteAll()
    }
    try! realm.write{
        realm.add(things)
    }
    
   }
   
   
    
               //  print("Description: ", decodedData.description)
 //  print("===================================")
} catch {
   print("decode error")
}
}


func fillDataBasefromJSON()
{
if let localData = readLocalFile(forName: "Data_ThingsToDo") {
   parse(jsonData: localData)
}

}
