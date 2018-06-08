//
//  mapViewer.swift
//  BP
//
//  Created by Yasin Turpcu on 18.03.2018.
//  Copyright © 2018 Yasin Turpcu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class mapViewer: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var name = "Konumunuz"
    var selectedLatitude : Double = 0
    var selectedLontitude : Double = 0
    var requestCLLocation = CLLocation()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        self.mapView.addAnnotation(annotation)
        
        if selectedLatitude != 0 {
            if selectedLontitude != 0 {
                self.requestCLLocation = CLLocation(latitude: selectedLatitude, longitude: selectedLontitude)
                CLGeocoder().reverseGeocodeLocation(requestCLLocation) { (placemarks, error) in
                    if let placemark = placemarks {
                        if placemark.count > 0 {
                            let newPlacemark = MKPlacemark(placemark: placemark[0])
                            let item = MKMapItem(placemark: newPlacemark)
                            item.name = self.name
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                            item.openInMaps(launchOptions: launchOptions)
                            self.navigationController?.popViewController(animated: true)
                            
                            
                        }
                    }
                }
            }
        }
        
        
    }
    override func remoteControlReceived(with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
