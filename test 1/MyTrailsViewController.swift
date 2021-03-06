//
//  MyTrailsViewController.swift
//  test 1
//
//  Created by students on 3/6/21.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth

class MyTrailsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var hiked: UILabel!
    @IBOutlet weak var info: UILabel!
//    var ref: DatabaseReference!
    let dataOne = DataLoader().generatedData
    
    @IBOutlet weak var saveButton: UIButton!
    
    let ref = Database.database().reference(withPath: "Hikes")
    let userID = Auth.auth().currentUser!.uid
    var array:[String]=[]


    override func viewDidLoad() {
        super.viewDidLoad()
        
    let user = Auth.auth().currentUser

        self.ref.child(user!.uid).getData { (error, snapshot) in
                 if let error = error {
                     print("Error getting data \(error)")
                 }
                 else if snapshot.exists() {
                     print("Got All my data \(snapshot.value!)")
                    
                    let enumerator = snapshot.children
                    while let nextObj = enumerator.nextObject() as? DataSnapshot {
                        //NSLog("current value:\(nextObj.value!)")
                        
                        self.array.append(nextObj.value as! String)
                        //NSLog   ("array after appending current data :",array)
                    }
                 }
                 else {
                     print("No data available")
                 }
             }
        
        }
//    func readHikes() {
//
//        ref.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
//      // Get user value
//      let value = snapshot.value as? NSDictionary
//      let username = value?["username"] as? String ?? ""
//
//      // ...
//      }) { (error) in
//        print(error.localizedDescription)
//    }
//}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return array.count
//        return DataLoader().generatedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
//        myCell.textLabel?.text = DataLoader().generatedData[indexPath.row].trailName
//
//
//        return myCell
        print("MyTrailsViewController.cellForRowAt")
        
        
        let trailname = array[indexPath.row]
//        print ("\n",user!.uid," ",trailname)
        
//        let range = NSRange(location: 0, length: dataOne[indexPath.row].trailName.utf16.count)
//        let regex = try! NSRegularExpression(pattern: "[a-z]at")
//        regex.firstMatch(in: trailname, options: [], range: range) != nil

        let replaced = trailname.replacingOccurrences(of: "|", with: ".")
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row] + "   more info"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Trails"
    }

//    @IBAction func testTheData(_ sender: Any) {
//
//        print("test the data")
//
//        let trailData : [String:Any] =   [
//            "TrailName":"BoggyHole" as NSObject, "DateHiked":"March18th"
//        ]
//        print(trailData)
//
//        let defaults = UserDefaults.standard
//        if (defaults.string(forKey: "email") != nil) {
//            let email = defaults.string(forKey: "email")!
//            print(email)
//            ref.child(email).setValue(trailData)
//            email.pref
//        }

     //   self.ref.child("users").child(user.uid).setValue(["username": username])
        
//    }
    
}
