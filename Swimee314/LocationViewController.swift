//
//  LocationViewController.swift
//  Swimee314
//
//  Created by ShinokiRyosei on 2016/03/16.
//  Copyright © 2016年 KasumiIwamoto. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var map: MKMapView!
    
    var location: CLLocationCoordinate2D! = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        map.delegate = self
        // Do any additional setup after loading the view.
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
                self.map.setCenterCoordinate(self.location, animated: true)
//                self.setMapSettings(self.location)
                self.map.addAnnotation(MKPlacemark(placemark: placemark))

            }
        }
        
    }
    
    func setMapSettings(point: CLLocationCoordinate2D) {
        let leastCoordSpan: Double = 0.005
        let center = CLLocationCoordinate2DMake(point.latitude, point.latitude)
        // 縮尺.
        let latitudeDist : CLLocationDistance = 100
        let lontitudeDist : CLLocationDistance = 100
        
        // Regionを作成.
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(center, latitudeDist, lontitudeDist)
        map.region = region
    }
    
    
    

    

}
