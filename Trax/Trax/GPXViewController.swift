//
//  ViewController.swift
//  Trax
//


import UIKit
import MapKit

class GPXViewController: UIViewController, MKMapViewDelegate {
    
    var gpxURL: URL? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gpxURL = URL(string: "http://cs193p.stanford.edu/Vacation.gpx")
    }

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .satellite
            mapView.delegate = self
        }
    }

}

