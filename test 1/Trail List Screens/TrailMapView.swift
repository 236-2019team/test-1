//
//  TrailMapView.swift
//  test 1
//
//  Created by students on 2/18/21.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase
import FirebaseAuth

class TrailMapView: UIViewController {

    //old outlets -- this was the problem!
   // @IBOutlet weak var TrailMap: MKMapView!
   // @IBOutlet weak var TrailName: UILabel!
    
    //new outlets
    @IBOutlet weak var TrailName: UILabel!
    @IBOutlet weak var TrailMap: MKMapView!
    @IBOutlet weak var Difficulty: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Acreage: UILabel!
    @IBOutlet weak var Address: UILabel!
    
    @IBOutlet weak var DidHikeButton: UIButton!
    
    let ref = Database.database().reference(withPath: "User-Trail-Rating")
    
    var selectedTrail:Int = 0
    let data = DataLoader().generatedData
    
    let annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    var dest = LogDestination()
    
    @IBAction func clickedDidHikeButton(_ sender: Any) {
        //self.dest.write("------------------------  TrailMapView.clickedDidHikeButton-")
        NSLog ("------------------------  TrailMapView.clickedDidHikeButton ")

        let user=Auth.auth().currentUser
        let trailname=TrailName.text!
        
        //-------------------------------------------
        // load dates
        //-------------------------------------------
        NSLog ("load dates")

        NSLog (user!.uid," ",trailname)
                
        let trailname2 = trailname.replacingOccurrences(of: ".", with: "&")
        
        NSLog ("trailname2:"+trailname2)
        
        NSLog ("load dates")

        //------------------------------------------------
        // send query
        //------------------------------------------------
        self.ref.child(user!.uid).child(trailname2).getData { (error, snapshot) in
            NSLog("===================  Processing Query  =================")

            if let error = error {
                NSLog(":Error getting data \(error)")
            }
            else if snapshot.exists() {
                NSLog("****Got data \(snapshot.value!)")
                self.appendNewDate(snapshot: snapshot,trailname2: trailname2)
                
            }
            else {
                NSLog("*****************No data available")
                var array:[String]=[]

                array.append(self.getCurrentDateString());
                
                //-------------------------------------------------
                // saving revised array back to Firebase
                //-------------------------------------------------
                NSLog ("SAVE dates array:\(array)")
                NSLog ("saving to \(trailname2)")
                
                self.ref.child(user!.uid).child(trailname2).setValue(array)

            }
        }
    }
    
    func encodeTrailname(trailname:String) -> String {
        return trailname.replacingOccurrences(of: ".", with: "&")
    }
    
    func getCurrentDateString() -> String {
        let now = Date()
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy HHmmss")
        
        let datetime = formatter.string(from: now)
        return datetime
    }
    
    func appendNewDate(snapshot:DataSnapshot,trailname2:String) {
        NSLog("===================  appendNewDate  =================")
        let user=Auth.auth().currentUser
        //let trailname=TrailName.text!
        
        //  let value=snapshot.value as? NSDictionary
        //  let dates = value?["dates"] as? String ?? ""
        //  //let user = User(username: username)
        //  print("dates:",dates)
        //
        //  array.append(dates);
        
        //  let myRef = self.ref.childByAppendingPath("array_node")
        //  ref.observeSingleEvent(of: .Value, with: { snapshot in
        
        NSLog("snapshot.childrenCount \(snapshot.childrenCount)")
        
        var array:[String]=[]
        
        let enumerator = snapshot.children
        while let nextObj = enumerator.nextObject() as? DataSnapshot {
            //NSLog("current value:\(nextObj.value!)")
            
            array.append(nextObj.value as! String)
            //NSLog   ("array after appending current data :",array)
        }
        /*
         let a = snapshot.value as! NSArray
         let b = (a as Array).filter {$0 is String}
         array.append(contentsOf: b)
         */
        //NSLog("array after appending current data :",array)
        //-----------------------------------------
        // append current date
        //-----------------------------------------
        //NSLog ("APPEND today to array")
        
        let now = Date()
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy HHmmss")
        
        let datetime = formatter.string(from: now)
        
        array.append(datetime);
        
        //-------------------------------------------------
        // saving revised array back to Firebase
        //-------------------------------------------------
        NSLog ("SAVE dates array:\(array)")
        NSLog ("saving to \(trailname2)")
        
        self.ref.child(user!.uid).child(trailname2).setValue(array)
        
        //self.ref.child(user!.uid).child(datetime).setValue(["trail":trailname])
        //self.ref.child(user!.uid).child(replaced).setValue(["dates":datetime])
        
        /*
         self.ref.child(user!.uid).child(replaced).setValue(array)
         
         //let values = ["Tiemstamp": datetime]
         let values = datetime+"x"
         //      let ref = FIRDatabase.database().reference().root.child("users").child(uid).child(getDate()).updateChildValues(["Places": values])]
         
         self.ref.child(user!.uid).child(replaced).updateChildValues(["Tiemstamp":values])
         */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print ("TrailMapView.viewDidLoad")
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
