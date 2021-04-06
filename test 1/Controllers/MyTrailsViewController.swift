//
//  MyTrailsViewController.swift
//  test 1
//
//  Created by students on 3/6/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyTrailsViewController: UIViewController,UITableViewDataSource {

    let dataOne = DataLoader().generatedData
    let ref = Database.database().reference(withPath: "User-Trail-Rating")
    var dest = LogDestination()
    var isLoaded=false
    
    var dataDict: [String:String]=[:] //trailname +dates
    //var hikedDates: [String:Array]=[[]]
    var hikedDates=[String: [String]]()
    
    @IBOutlet weak var trailName: UITextField!
    
    override func viewDidLoad() {
        print("MyTrailsViewController.viewDidLoad:", dataOne.count)

        super.viewDidLoad()
        
        let user=Auth.auth().currentUser

        self.ref.child(user!.uid).getData {
            (error, snapshot) in
            
            if let error = error {
                print("Error getting data \(error)")
            }
            
            else if snapshot.exists() {
                print("\nGot All data \(snapshot.value!)")

                self.extractData(snapshot)
            }
            
            else {
                print("No data available")
            }
        } // end self.ref.child(user!.uid).getData

    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection
                    section: Int)
                -> Int {
        print ("numberOfRowsInSection",dataDict.keys.count)
        while (!isLoaded) {
            sleep(UInt32(0.1))
        }
        return dataDict.keys.count
    }

    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
                    indexPath: IndexPath)
                    -> UITableViewCell {
        
        print("---------------------------------------")
        print("MyTrailsViewController.cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.detailTextLabel?.numberOfLines=3
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
//        print(type(of:dataDict.keys))
//        print(dataDict.values)

        let rowKey=Array(dataDict.keys)[indexPath.row]
        let rowValue=dataDict[rowKey]!     //Array(dataDict.values)[indexPath.row]

        print (rowKey)
        print (rowValue)
        
        print (hikedDates[rowKey]!)
        
        for String in hikedDates[rowKey] {
            print ("date:",date as? String)
        }
        
        
        
        cell.textLabel?.text =  "\(rowKey)\n \(rowValue)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection
                    section: Int)
                -> String? {
        return "My Trails"
    }

    fileprivate func extractData(_ snapshot: DataSnapshot) {
        //                print("\n-===================================--")
        if let dict = snapshot.value as? NSDictionary {
            //                    print("dict:",dict)
            print("dict.allKeys:",dict.allKeys)
            //                    print("dict.allValues:",dict.allValues)
            //                   print ("--------------------")
            for key in dict.allKeys {
                //                        print("key:",key)
                //                        print (dict[key])
                //                        print ("type(of:dict[key]:",type(of:dict[key]))
                
                //let array=NSArray(dict[key]:keyStoreBySize)
                
                if let dateArray = dict[key] as? NSArray {
                    //                            print("dateArray",dateArray)
                    
                    var datesArray: [String]=[]
                    
                    var strs=""
                    for str in dateArray {
                        print(str) // Optional<Any>
                        print ("type(of:dict[str]:",type(of:dict[str]))
                        
                        strs=strs+"\n "+"\(str)"
                        //if let str = str {
                        datesArray.append(str as? String ?? "default value")
                        //}
                    }
                    self.dataDict[key as! String]="\(strs)"

                    hikedDates[key as! String]=datesArray

                }
                //                        print ("--------------------")
            }
        }
        self.isLoaded=true
    }
    

}
