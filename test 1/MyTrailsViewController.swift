//
//  MyTrailsViewController.swift
//  test 1
//
//  Created by students on 3/6/21.
//

import UIKit

class MyTrailsViewController: UIViewController, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return DataLoader().generatedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("test")
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        myCell.textLabel?.text = DataLoader().generatedData[indexPath.row].trailName
        
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Trails"
    }

}

