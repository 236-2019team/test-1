//
//  OverviewMapViewController.swift
//  test 1
//
//  Created by students on 3/7/21.
//

import Foundation
import MapKit
import CoreLocation
import UIKit

class OverviewMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var overviewMap: MKMapView!
    
    let annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000

    override func viewDidLoad() {
        super.viewDidLoad()

        checkLocationServices()
       
        annotation.coordinate = CLLocationCoordinate2D(latitude: 41.34564, longitude: -72.28333)
                annotation.title = "Lay Preserve"
                annotation.subtitle = "Lords Meadow Ln"
                overviewMap.addAnnotation(annotation)
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
           overviewMap.setRegion(region, animated: true)
       }
      
       func checkLocationAuthorization() {
           switch CLLocationManager.authorizationStatus() {
           case .authorizedWhenInUse:
               overviewMap.showsUserLocation = true
               followUserLocation()
               locationManager.startUpdatingLocation()
               break
           case .denied:
               // Show alert
               break
           case .notDetermined:
               locationManager.requestWhenInUseAuthorization()
           case .restricted:
               // Show alert
               break
           case .authorizedAlways:
               break
           }
       }
       
       func checkLocationServices() {
           if CLLocationManager.locationServicesEnabled() {
               setupLocationManager()
               checkLocationAuthorization()
           } else {
               // the user didn't turn it on
           }
       }
       
       func followUserLocation() {
           if let location = locationManager.location?.coordinate {
               let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
               overviewMap.setRegion(region, animated: true)
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           checkLocationAuthorization()
       }
       
       func setupLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
       }
    
}
