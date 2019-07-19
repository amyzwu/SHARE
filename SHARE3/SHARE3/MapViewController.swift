//
//  MapViewController.swift
//  SHARE3
//
//  Created by Apple on 7/18/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var mapAnnotations = [customPin]()
    var locationManager = CLLocationManager()
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var nameOfPlace: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var websiteLink: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MapView.delegate = self
        MapView.layer.cornerRadius = 7.5
        MapView.showsUserLocation = true
            if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||  CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            print("Please turn on location services or GPS")
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        self.MapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named: "shelter")
        annotationView.canShowCallout = true
        return annotationView
    }
    let shelterLocations = [
    ["name" : "Goodwill Southern California Donation Center","latitude" : 34.048456,"longitude" : -118.435387,"mediaURL" : "goodwillsocal.org","phoneNumber" : "3104412740"],
    ["name" : "The Salvation Army Family Store & Donation Center","latitude" : 33.959841,"longitude" : 33.959841,"mediaURL" : "Satruck.org","phoneNumber" : "3237597681"],
    ["name" : "A Sense Of Home","latitude" : 33.916738,"longitude" : -118.335002,"mediaURL" : "Asenseofhome.org","phoneNumber" : "3108048998"],
    ["name" : "Los Angeles Regional Food Bank","latitude" : 34.007484,"longitude" : -118.241887,"mediaURL" : "http://www.lafoodbank.org","phoneNumber" : "3232343030"],
    ["name" : "World Harvest Food Bank","latitude" : 34.043261,"longitude" : -118.318055,"mediaURL" : "https://www.worldharvestla.org","phoneNumber" : "2137462227"],
    ["name" : "Sova-Bay Food Pantry","latitude" : 34.054819,"longitude" : -118.384861,"mediaURL" : "https://www.jfsla.org/page.aspx?pid=300","phoneNumber" : "3102880286"],
    ["name" : "North Hollywood Interfaith Food Pantry","latitude" : 34.150098,"longitude" : -118.387236,"mediaURL" : "https://nhifp.org","phoneNumber" : "8187603575"],
    ["name" : "Food On Foot","latitude" : 34.069140,"longitude" : -118.406751,"mediaURL" : "https://www.foodonfoot.org","phoneNumber" : "3104420088"],
    ["name" : "Food Pantry Lax","latitude" : 33.969828,"longitude" : -118.350290,"mediaURL" : "http://www.westsidefoodbankca.org/index.php?option=com_content&task=view&id=70&Itemid=94","phoneNumber" : "3106775597"],
    ["name" : "Los Angeles Mission","latitude" : 34.045353,"longitude" : -118.245060,"mediaURL" : "https://losangelesmission.org/ways-to-give/donate-food-clothing-goods/","phoneNumber" : "2136291227"],
    ["name" : "Society of St. Vincent de Paul Los Angeles Thrift Store","latitude" : 34.077214,"longitude" : -118.221281,"mediaURL" : "https://svdpla.org/","phoneNumber" : "3232246280"]
    ]
    func addPlaces() {
        for dictionary in shelterLocations {
            let latitude = CLLocationDegrees(dictionary["latitude"] as! Double)
            let longitude = CLLocationDegrees(dictionary["longitude"] as! Double)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            print(coordinate)
            let name = dictionary["name"] as! String
            // let mediaURL = dictionary["mediaURL"] as! String
            let pin = customPin(pinTitle: name, pinSubTitle: "", location: coordinate)
            mapAnnotations.append(pin)
            self.MapView.addAnnotation(pin)
        }
        self.MapView.addAnnotations(mapAnnotations)
        // imageChoice = "pin2"
    }
}
