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
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.283921, longitude: -157.831661)
        centerMapOnLocation(initialLocation)
        
        loadInitialData()
        mapView.addAnnotations(artworks)
        
        mapView.delegate = self
        
    }
    
    var artworks = [Artwork]()
    func loadInitialData() {
        // 2 Read the PublicArt.json file into an NSData object
        let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json");
        var data: Data?
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
        } catch _ {
            data = nil
        }
        
        // 3 Use NSJSONSerialization to obtain a JSON object
        var jsonObject: Any? = nil
        if let data = data {
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
            } catch _ {
                jsonObject = nil
            }
        }
        
        // 4 Check that the JSON object is a dictionary where the keys are Strings and the values can be Any
        if let jsonObject = jsonObject as? [String: Any],
            // 5 loop through "data" arrays, checking that each element is an array
            let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
            for artworkJSON in jsonData {
                if let artworkJSON = artworkJSON.array,
                    // Pass each artwork’s array to the fromJSON method and append it to the artworks array.
                    let artwork = Artwork.fromJSON(artworkJSON) {
                    artworks.append(artwork)
                }
            }
        }
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
