//
//  MyTrailsViewController.swift
//  test 1
//
//  Created by students on 3/6/21.
//

import UIKit

class MyTrailsViewController: UIViewController {

    
    let dataOne = DataLoader().generatedData
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // change return to filteredData.count
        print("TechnoTicks!!!!", dataOne.count)
        return dataOne.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("test")
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = dataOne[indexPath.row].trailName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Trails"
    }

}
