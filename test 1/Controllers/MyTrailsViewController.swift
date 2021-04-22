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

    let ref = Database.database().reference(withPath: "User-Trail-Rating")
    
    var isLoaded=false
    
    var hikedDates=[String: [String?]]()
    
    override func viewDidLoad() {
        print("MyTrailsViewController.viewDidLoad:")

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
        print ("numberOfRowsInSection",hikedDates.keys.count)
        while (!isLoaded) {
            sleep(UInt32(0.1))
        }
        return hikedDates.keys.count
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
        
        let trailNameKey=Array(hikedDates.keys)[indexPath.row]
        let trailArray=hikedDates[trailNameKey]!     //Array(dataDict.values)[indexPath.row]

        print (trailNameKey)
        
        //--------------------------------------
        // Date Array
        //--------------------------------------
//        print (trailArray)
        
        print (hikedDates[trailNameKey]!)
        
        let anArray = hikedDates[trailNameKey]
//        print (anArray ?? "default value")
        
//        print ("\(anArray!.count)")
        
        for (index,str) in anArray!.enumerated() {
            print ("\(index+1) \(str!)")
        }

        print ("last:",anArray!.last!!)
        
        //-------------------------------------
        // Set label to rowKey
        //-------------------------------------
        //cell.textLabel?.text =  "\(trailNameKey)\n \(trailArray)"

        let stackView = cell.contentView.subviews[0];
        
        print (stackView)
        
        let topView = UIView()
        
        let label = UILabel(/*frame:
                            CGRect(x: 0,
                            y: 0,
                            width: 200,
                            height: 21)*/)
        //label.center = CGPoint(x: 160, y: 285)
        //label.textAlignment = .center
        label.text = trailNameKey

        topView.addSubview(label)
        
        print (topView)
        
        stackView.addSubview(topView);

        let label2 = UILabel(/*frame:
                            CGRect(x: 0,
                            y: 0,
                            width: 200,
                            height: 21)*/)
        //label2.center = CGPoint(x: 160, y: 285)
        //label2.textAlignment = .center
        label2.text = "4/15/2021 08:30"

        let nextView=UIView()
        nextView.addSubview(label2)
        
        stackView.addSubview(nextView)
        
        //let tableView = UITableView()
        //tableView.dataSource(anArray)

        
        /*
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        let subView = contentView.addSubview(stackView)
        subView.addSubview("test");
        
        
        let label = UILabel(frame: CGRect(x: 0,
                            y: 0,
                            width: 200,
                            height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "I'm a test label"

        trailView.addSubview(label)
        
        //trailLabel.text=trailNameKey
        //datesTable.append("test")
        //data.append("Test")
        */
        
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
                    
                    //var strs=""
                    for str in dateArray {
                        print(str) // Optional<Any>
                        print ("type(of:dict[str]:",type(of:dict[str]))
                        
                    //    strs=strs+"\n "+"\(str)"
                        //if let str = str {
                        datesArray.append(str as? String ?? "default value")
                        //}
                    }
                    //self.dataDict[key as! String]="\(strs)"

                    hikedDates[key as! String]=datesArray

                }
//                        print ("--------------------")
            }
        }
        self.isLoaded=true
    }
    

}
