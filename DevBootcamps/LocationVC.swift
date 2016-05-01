//
//  LocationVC.swift
//  DevBootcamps
//
//  Created by Pierre De Pingon on 01/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    // Mark addresse
    let addresses = [
    
        "Renaissance Centre, 16-17 New St, Johannesburg, 2000, Afrique du Sud",
        "16 Kruis St, Johannesburg, 2092, Afrique du Sud",
        "2094, 15 Troye St, Johannesburg, 2094, Afrique du Sud"
    
    
    
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        
        for add in addresses {
            getPlacemarkFromAddress(add)
        }

    }
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }



    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            map.showsUserLocation = true
            
        } else {
            
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
        
    }
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            centerMapOnLocation(loc)
        }
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(BootCampAnnotation) {
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.yellowColor()
            annoView.animatesDrop = true
            return annoView
            
        } else if annotation.isKindOfClass(MKUserLocation)
        {
            return nil
        }
        
        return nil
    }
    
    
    func creatAnnotationForLocation(location: CLLocation) {
        let bootcamp = BootCampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }

    func getPlacemarkFromAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                   self.creatAnnotationForLocation(loc)
                }
                
            }
        }
    }
}

