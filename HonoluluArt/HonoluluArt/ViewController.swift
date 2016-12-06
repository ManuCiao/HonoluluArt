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
    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
       
        // Dispose of any resources that can be recreated.
    }


}

