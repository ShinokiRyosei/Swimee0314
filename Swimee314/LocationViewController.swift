//
//  LocationViewController.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/16.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import MapKit
import Parse

class LocationViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var map: MKMapView!
    @IBOutlet var doneButton: UIButton!
    
    var location: CLLocationCoordinate2D! = CLLocationCoordinate2D()
    
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        map.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.enabled = false
        doneButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(searchBar.text!) { (placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                self.location = CLLocationCoordinate2D(latitude: (placemark.location?.coordinate.latitude)!, longitude: (placemark.location?.coordinate.longitude)!)
                self.map.setCenterCoordinate(self.location, animated: false)
//                self.setMapSettings(self.location)
                self.map.addAnnotation(MKPlacemark(placemark: placemark))
                self.doneButton.enabled = true
                self.doneButton.hidden = false
            }
        }
        
    }
    
    
    @IBAction func pushDone() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let id = defaults.objectForKey("objectId") as! String
        var travelModel: PFObject!
        let query = PFQuery(className: TravelTitles.parseClassName())
        query.getObjectInBackgroundWithId(id) { (object, error) -> Void in
            if error == nil {
                if let fetchObject = object {
                    travelModel = fetchObject
                    let geo = PFGeoPoint(latitude: self.location.latitude, longitude: self.location.longitude)
                    let data = TravelLocationModel(location: geo, title: travelModel)
                    data.saveInBackground()
                }
            }
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    
    

    

}
