//
//  MapViewController.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/16.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var geoPointArray = [PFGeoPoint]()
    @IBOutlet var map: MKMapView!
    var geoCoder: CLGeocoder!
    
    var location: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.read()
        
        for i in 0 ..< geoPointArray.count {
            var latitude = geoPointArray[i].latitude
            var longtitude = geoPointArray[i].longitude
            self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
            self.map.setCenterCoordinate(self.location, animated: false)
            //                self.setMapSettings(self.location)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            self.map.addAnnotation(annotation)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func read() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let pfQuery = PFQuery(className: TravelTitles.parseClassName())
        pfQuery.getObjectInBackgroundWithId(defaults.objectForKey("objectId") as! String) { (fetchObject, error) -> Void in
            if error == nil {
                if let object = fetchObject {
                    let query = PFQuery(className: TravelLocationModel.parseClassName())
                    query.whereKey("title", equalTo: object)
                    
                    query.findObjectsInBackgroundWithBlock { (fetchObjects, error) -> Void in
                        if error == nil {
                            if let objects: [PFObject] = fetchObjects! {
                                for object in objects {
                                    self.geoPointArray.append(object["location"] as! PFGeoPoint)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
    func setMapSettings(point: CLLocationCoordinate2D) {
        let leastCoordSpan: Double = 0.005
        let center = CLLocationCoordinate2DMake(point.latitude, point.latitude)
        // 縮尺.
        let latitudeDist : CLLocationDistance = 10
        let lontitudeDist : CLLocationDistance = 10
        
        // Regionを作成.
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(center, latitudeDist, lontitudeDist)
        map.region = region
    }
    
    
    
    
    
    
    
}
