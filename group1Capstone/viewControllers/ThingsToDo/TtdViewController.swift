//
//  TtdViewController.swift
//  group1Capstone

//  Created by Jose Alberto Martinez Pineda on 2022-08-05.
//

import UIKit
import RealmSwift
import Realm
import MapKit

class TtdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate  {
    
    //Variables
    var things = [Thing]()
    var filterData: [Thing]!
    var scopeSelected = ""

    
    
    
    //Outlets declarations
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        
        let thingLabel = self.filterData[indexPath.row]
    
        cell.titleThing.text = thingLabel.nameOfThing
        cell.reviewThing.text = "\(thingLabel.review) reviews"
        cell.rateThing.text = "\(thingLabel.rate)"
        cell.categoryThing.text = thingLabel.category
        cell.hourThing.text = thingLabel.hours
    
        cell.fillStars(HowManyStars: Int(thingLabel.rate))
     
        print("Height: \(cell.bounds.height)")
       
        cell.imageThing.imageFromServerURL(urlString: thingLabel.image, PlaceHolderImage: UIImage(systemName: "nosign")!)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Here I am")
        let thing = self.things[indexPath.row]
        print("The thin is  \(thing)")
       // let detailController = DetailController(thing: thing)
       // detailController.thing = thing
        //self.show(detailController,sender: self )
        
        let vc = storyboard?.instantiateViewController(identifier: "detailSegue") as? DetailController
        vc?.thing=thing
   //self.present(detailController, animated: true)
        self.navigationController?.pushViewController(vc!, animated: true)
        
    //    self.performSegue(withIdentifier: "detailSegue", sender: self)
  
 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 214
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        scopeSelected = searchBar.scopeButtonTitles![selectedScope]
        print(scopeSelected)
    }
   // Mark: Search Bar Config
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterData = []
        if searchText == "" ||  searchText == nil {
            
            filterData = things
            
        }
        else {
          
            filterData = things.filter {
              
                thing in
                let scopeMatch = (scopeSelected=="All" || thing.category.contains(scopeSelected))

                let searchTextMatch = thing.nameOfThing.lowercased().contains(searchText.lowercased())
                    return scopeMatch && searchTextMatch
                }
                
                        
        }// else
        self.myTable.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        myTable.delegate = self
        myTable.dataSource = self
        
         
        searchBar.scopeButtonTitles=["All","Parks & Trails","Food & Drinks","Attractions & Entertainment"]
        scopeSelected = searchBar.scopeButtonTitles![0]
        searchBar.showsScopeBar = true
        searchBar.delegate = self
        definesPresentationContext = false
       
        
        //This is just for the first time or to reset database
        fillDataBasefromJSON()
        // fillDataBase()
       
        let realm = try! Realm()
        let path = realm.configuration.fileURL?.path
        
        let  resultc = realm.objects(Thing.self)
        
        for thing in resultc {
            
            things.append(thing)
        }
        filterData = things

        print("Path: \(String(describing: path))" )
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIImageView {

 public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {

        if self.image == nil{
              self.image = PlaceHolderImage
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }}
