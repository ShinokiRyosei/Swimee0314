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
        
    }
    
    
    

    

}
