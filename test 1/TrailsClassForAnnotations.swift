//
//  TrailsClassForAnnotations.swift
//  test 1
//
//  Created by students on 3/11/21.
//

import Foundation
import MapKit

class TrailsClassForAnnotations: NSObject, MKAnnotation {
  let title: String?
  let difficulty: String?
  let coordinate: CLLocationCoordinate2D

    var markerTintColor: UIColor  {
      switch difficulty {
      case "easy":
        return .green
      case "medium":
        return .orange
      case "hard":
        return .red
      default:
        return .blue
      }
    }

    
  init(
    trailName: String?,
    difficulty: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = trailName
    self.difficulty = difficulty
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return "subtitle"
  }
    
    init?(feature: MKGeoJSONFeature) {
      // 1
      guard
        let point = feature.geometry.first as? MKPointAnnotation,
        let propertiesData = feature.properties,
        let json = try? JSONSerialization.jsonObject(with: propertiesData),
        let properties = json as? [String: Any]
        else {
          return nil
      }

      // 3
      title = properties["trailName"] as? String
      difficulty = properties["difficulty"] as? String
      coordinate = point.coordinate
      super.init()
    }

}
