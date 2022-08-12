//
//  ViewController.swift
//  group1Capstone
//
//  Created by user206864 on 8/8/22.
//

import UIKit
import CoreData
import SwiftUI

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    struct rev: Codable {
        let id : Int
        let name : String
        let rating : Int
        let review : String
    }
    
    struct loc: Codable {
        let name : String
        let description : String
        let latitude : String
        let longitude : String
        let image : String
        var review = [rev]()
    }
    
    var locArray:[loc] = []
    var loggedIn: Bool = false
//    var user: User
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        do{
        
            fetchLocation()
           
           
            let allUser = try context.fetch(User.fetchRequest())
            
         /*   if(allUser == []){
                var user = User(context: context)
                try context.save()

                allUser = try context.fetch(User.fetchRequest())
            }*/
            if(allUser != []){
                if(allUser[0].loggedIn){
                    loggedIn = true
                }
               
            }
            
           
            
            
            
        }catch{
            fatalError("Something wrong with persistent container")
        }

//        self.user =
        
        
        
//        self.loggedIn = true
    }

    @IBAction func goTapped(_ sender: Any) {
        
        if loggedIn == true {

//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let homeViewController  = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController

            self.view.window?.rootViewController = homeViewController
            
            self.view.window?.makeKeyAndVisible()
            
        }
        else {

        let storyBoard: UIStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginStory") as! LoginViewController
            
        self.view.window?.rootViewController = loginViewController
                          self.view.window?.makeKeyAndVisible()
            
        }
    }
    
    func fetchLocation() {
        if let path = Bundle.main.path(forResource: "location", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult:[AnyObject] = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [AnyObject]
                
                var id = 0;
                
                
                
                for item in jsonResult{
                  
                    id+=1;
                    
                guard let name = item["name"] as? String else {
                    
                    return
                }
              
                
                guard let latitude = item["latitude"] as? String else {

                    return
                }
                    
                    
                    guard let longitude = item["longitude"] as? String else {
                       
                        return
                    }
                    
                    guard let description = item["description"] as? String else {
                       
                        return
                    }
                    guard let image = item["image"] as? String else {
                       
                        return
                    }
                    
                    guard let review = item["rating"] as? [AnyObject] else {

                        return
                    }
                    
                    var revId = 0
                    var revArray:[rev] = [rev]()
                    for item2 in review{
                      
                        revId+=1;
                        guard let name2 = item2["name"] as? String else {
                           
                            return
                        }
                        guard let rating = item2["rating"] as? Int else {
                           
                            return
                        }
                        
                        guard let review2 = item2["review"] as? String else {
                           
                            return
                        }
                        
                        let newElement = rev(id: revId, name: name2, rating: rating, review: review2)
                        
                        revArray.append(newElement)
                        
                    }
                    
                    let newLoc = loc(name: name, description: description, latitude: latitude, longitude: longitude, image: image, review: revArray)
            
                    self.locArray.append(newLoc)
    
                }
                
              } catch {
                   // handle error
              }
        }else{
            print("file not found")
        }
    }
    
}

