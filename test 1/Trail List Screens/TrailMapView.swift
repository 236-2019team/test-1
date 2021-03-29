//
//  TrailMapView.swift
//  test 1
//
//  Created by students on 2/18/21.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class TrailMapView: UIViewController {


    @IBOutlet weak var TrailName: UILabel!
    @IBOutlet weak var TrailMap: MKMapView!
    @IBOutlet weak var Difficulty: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Acreage: UILabel!
    @IBOutlet weak var Address: UILabel!
    
    let ref = Database.database().reference(withPath: "Hikes")


    var selectedTrail:Int = 0
    let data = DataLoader().generatedData
    
    let annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TrailName.text = data[selectedTrail].trailName
        Difficulty.text = data[selectedTrail].difficulty
        Description.text = data[selectedTrail].description
        Acreage.text = data[selectedTrail].acreage
        Address.text = data[selectedTrail].address
        
        let trailLatitude = data[selectedTrail].latitude
        let trailLongitude = data[selectedTrail].longitude
        
        let initialLocation = CLLocation(latitude: trailLatitude, longitude: trailLongitude)
        
        let coordinateRegion = MKCoordinateRegion(
           center: initialLocation.coordinate,
           latitudinalMeters: 10000,
           longitudinalMeters: 10000)
         
         TrailMap.setRegion(coordinateRegion, animated: true)
         
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: trailLatitude, longitude: trailLongitude)
            annotation.title = data[selectedTrail].trailName
            annotation.subtitle = data[selectedTrail].address
            TrailMap.addAnnotation(annotation)
        locationManager.startUpdatingLocation()
       
    }
    
    @IBAction func saveHike(_ sender: Any) {
        
        let formatter : DateFormatter = DateFormatter()
          formatter.dateFormat = "d-M-yy"
          let myStr : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        
//        let trailData : [String:Any] =   [
//            "TrailName":TrailName.text as Any, //as! NSObject,
//            "DateHiked":"March 25"
//                //Date().localizedDescription(dateStyle: .short, timeStyle: .short)
//        ]
        
        let userID = Auth.auth().currentUser!.uid
               
//        ref.child(userID).child(TrailName.text!).setValue(myStr)
        ref.child(userID).child(myStr).setValue(TrailName.text!)

        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
