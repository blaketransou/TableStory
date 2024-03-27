//
//  ViewController.swift
//  TableStory
//
//  Created by Transou, Blake M on 3/20/24.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Austin Women's Boxing Club", neighborhood: "Downtown", desc: "A boxing club for all levels for women.", lat: 30.24190844306894, long: -97.78143386032852, imageName: "rest1"),
    Item(name: "Legends Boxing South Austin", neighborhood: "Hyde Park", desc: "All levels boxing classes that focus on footwork, technique, self defense, and conditioning.", lat: 30.193428160557374, long:-97.84237666032944, imageName: "rest2"),
    Item(name: "Easley Boxing and Fitness", neighborhood: "South Central", desc: "A boxing gym for all ages and levels.", lat: 30.244167, long: -97.771785, imageName: "rest3"),
    Item(name: "Archetype Boxing Club", neighborhood: "UT", desc: " USA Boxing Certified instructors designed the boxing classes to offer an authentic experience similar to a professional boxer's. ", lat: 30.358790959103764, long: -97.7348544449858, imageName: "rest4"),
    Item(name: "Forty Five Boxing", neighborhood: "Hyde Park", desc: "Boxing classes for all ages in Buda.", lat: 30.034985679381755, long: -97.82780804499218, imageName: "rest5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
 {
    
    
    @IBOutlet weak var theTable: UITableView!
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        
        
        //Add image references
                    let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
                    
        
        
        return cell!
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
    
    
    
    
    
    
    
    // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        
        //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }

        
        
        

    }


}

