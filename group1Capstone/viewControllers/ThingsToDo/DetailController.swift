//
//  DetailController.swift
//  group1-capstone-project
//
//  Created by Jose Alberto Martinez Pineda on 2022-08-07.
//

import UIKit
import MapKit
import CoreLocation
class DetailController: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate   {

    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var titleThing: UILabel!
    @IBOutlet weak var descriptionThing: UITextView!
    @IBOutlet weak var hourThing: UILabel!
    @IBOutlet weak var phoneThing: UILabel!
    
    @IBOutlet weak var reviewsThing: UILabel!
    @IBOutlet weak var provinceThing: UILabel!
    
    @IBOutlet weak var addressThing: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    let manager = CLLocationManager()
    var thing: Thing?
    
    var initialLocation : CLLocation? = nil
   var  coordinateThing = CLLocationCoordinate2D()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count in detailController \(thing?.comments.count)" )
        return thing?.comments.count ?? 0
    }
    
    
    @IBAction func addReview(_ sender: Any) {
        
       
        let vc = storyboard?.instantiateViewController(identifier: "writeReview") as? CommentViewController
        vc?.thing=thing
        vc?.modalPresentationStyle = .overCurrentContext
        vc?.modalTransitionStyle = .coverVertical
        
        present(vc! , animated: true, completion: {
            self.thing = getThing(idThing : self.thing!.id)
            print("Last review: \(self.thing?.review)")
            self.myTable.reloadData()
            
        })
        
         
       
       // self.navigationController?.segue(vc!, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "CellReview", for: indexPath) as! ReviewsViewCell
        print("Cell detail")
        let thingLabel = self.thing?.comments[indexPath.row]
     
        cell.userThing.text = thingLabel?.idUser
        cell.commentThing.text = thingLabel?.comment
        cell.dateComment.text = thingLabel?.date
                
        
        if let a = thingLabel?.rate {
            //add stars
            cell.fillStars(HowManyStars: Int(thingLabel!.rate))
           // cell.rateThing.text = "\(a)"
        }
        
   
     
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        print("Call view Did Load")
        
        // Do any additional setup after loading the view.
        myTable.delegate = self
        myTable.dataSource = self
        coordinateThing = CLLocationCoordinate2D(latitude: Double(thing!.latitude)!, longitude: Double(thing!.longitude)! )
        
        initialLocation = CLLocation(latitude: Double(thing!.latitude)!, longitude: Double(thing!.longitude)!)
        
        
        titleThing.text = thing?.nameOfThing
        descriptionThing.text = thing?.thingDescription
        phoneThing.text = thing?.Phone
        addressThing.text = thing?.address
        provinceThing.text = thing?.Province
        reviewsThing.text = "(\(thing?.review ?? 0))"
        
    }
    
    //Using didApper once map shows up to now register the values for GPS location services and set properties of our manager
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Call view Did appear")
        
        
        
        let coordinate = coordinateThing
        let distanceSpan: CLLocationDistance = 30
        let span = MKCoordinateSpan (latitudeDelta: 0.01 , longitudeDelta: 0.01)//8804056
        let region = MKCoordinateRegion (center: coordinate, span:span)
         //We create the pin
        let pin = MKPointAnnotation()
        pin.coordinate = coordinateThing
        pin.title = thing?.nameOfThing
        
        //We add the pin to the mapview
        myMap.addAnnotation(pin)
        myMap.setRegion(region, animated: false)
        
        myMap.delegate = self
        
        manager.delegate = self
         
        manager.desiredAccuracy = kCLLocationAccuracyBest
        //request the authorization
        manager.requestWhenInUseAuthorization()
        //
        manager.startUpdatingLocation()
        
         
       
        
    }
    //render function to get Longitude and latitude
    func render (_ location: CLLocation){
        let currentCoordinate = CLLocationCoordinate2D (latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        distance.text = String(format:"%.2f km", (0.001*location.distance(from: initialLocation!) ))
 
        
         
      
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
        manager.startUpdatingLocation()
        render(location)
        }
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
