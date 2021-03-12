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
    
    let data = DataLoader().generatedData

    private var trails: [TrailsClassForAnnotations] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLocationServices()
       
//        annotation.coordinate = CLLocationCoordinate2D(latitude: data[eachTrail].latitude, longitude: data[eachTrail].longitude)
//                annotation.title = data[eachTrail].trailName
//                annotation.subtitle = data[eachTrail].address
//                overviewMap.addAnnotation(annotation)
//        locationManager.startUpdatingLocation()
       
//        overviewMap.register(
//          TrailMarkerView.self,
//          forAnnotationViewWithReuseIdentifier:
//            MKMapViewDefaultAnnotationViewReuseIdentifier)

        loadInitialData()
        overviewMap.addAnnotations(trails)

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
    
    private func loadInitialData() {
      // 1
      guard
        let fileName = Bundle.main.url(forResource: "trailAnnotations", withExtension: "json"),
        let trailData = try? Data(contentsOf: fileName)
        else {
          return
      }

      do {
        // 2
        let features = try MKGeoJSONDecoder()
          .decode(trailData)
          .compactMap { $0 as? MKGeoJSONFeature }
        // 3
        let validWorks = features.compactMap(TrailsClassForAnnotations.init)
        // 4
        trails.append(contentsOf: validWorks)
      } catch {
        // 5
        print("Unexpected error: \(error).")
      }
    }

}
extension OverviewMapViewController: MKMapViewDelegate {
  // 1
  func mapView(
    _ mapView: MKMapView,
    viewFor annotation: MKAnnotation
  ) -> MKAnnotationView? {
    // 2
    guard let annotation = annotation as? TrailsClassForAnnotations else {
      return nil
    }
    // 3
    let identifier = "artwork"
    var view: MKMarkerAnnotationView
    // 4
    if let dequeuedView = mapView.dequeueReusableAnnotationView(
      withIdentifier: identifier) as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      // 5
      view = MKMarkerAnnotationView(
        annotation: annotation,
        reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }
}

