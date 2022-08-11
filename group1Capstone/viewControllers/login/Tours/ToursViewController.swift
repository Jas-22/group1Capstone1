//
//  ToursViewController.swift
//  group1Capstone
//
//  Created by Jazz Stephan on 08/08/22.
//

import UIKit

class ToursViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct TourLocation {
        var name: String
        var description: String
        var longitude: Decimal
        var latitude: Decimal
        var image: UIImage?
        var included: Bool
        
        init(name: String, description: String, longitude: Decimal, latitude: Decimal, image: UIImage?, included: Bool) {
            self.name = name
            self.description = description
            self.longitude = longitude
            self.latitude = latitude
            self.image = image
            self.included = included
        }
    }
    
//    var locations = ["Test location 1","Test location 2","Test location 3"]
//    var locationImages = [
//        UIImage(named: "Huron Natural Area"),
//        UIImage(named: "Huron Natural Area"),
//        UIImage(named: "Huron Natural Area")
//    ]
    
    var locations: [TourLocation] = [
        TourLocation(
            name: "Waterloo Park",
            description: "Sizable recreation area with a splash pad, farm, mill replica, picnic sites & sports facilities.",
            longitude: 43.465554095551006,
            latitude: -80.53362598440994,
            image: UIImage(named: "Waterloo Park"),
            included: true),
        TourLocation(
            name: "Market Road Antiques",
            description: "Antique store.",
            longitude: 43.50928201322487,
            latitude: -80.55770196943843,
            image: UIImage(named: "Market Road Antiques"),
            included: true),
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    @IBOutlet weak var myTable: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyTableViewCell
        let citylabel = self.locations[indexPath.row].name
        let cityimage = self.locations[indexPath.row].image
        cell.myLocationLabel.text = citylabel
        cell.myLocationImage.image  = cityimage
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
//        myTable.rowHeight = 256.00
    }
}
