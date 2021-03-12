//
//  TrailCustomAnnotations.swift
//  test 1
//
//  Created by students on 3/11/21.
//

//import Foundation
//import MapKit
//
//class TrailMarkerView: MKMarkerAnnotationView {
//  override var annotation: MKAnnotation? {
//    willSet {
//      // 1
//      guard let trail = newValue as? TrailsClassForAnnotations else {
//        return
//      }
//      canShowCallout = true
//      calloutOffset = CGPoint(x: -5, y: 5)
//      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//
//      // 2
//      markerTintColor = trail.markerTintColor
//      if let letter = trail.difficulty?.first {
//        glyphText = String(letter)
//      }
//    }
//  }
//}
