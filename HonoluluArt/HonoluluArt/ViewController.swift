//
//  ViewController.swift
//  HonoluluArt
//
//  Created by Manuela Sabatino on 12/5/16.
//  Copyright © 2016 Manuela Sabatino. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 3000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location in Genzano
        let initialLocation = CLLocation(latitude: 41.706845, longitude: 12.696308)
        
        centerMapOnLocation(initialLocation)
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
       
        // Dispose of any resources that can be recreated.
    }

    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

