//
//  ArrayTableViewController.swift
//  test 1
//
//  Created by Administrator on 2/12/21.
//

import UIKit


class ArrayTrailViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Split string into array
        let stringToSplit = "BoggyHole description hard 200"
        let splitString = stringToSplit.components(separatedBy: " ")
        
        let splitToCharacters = Array(stringToSplit)
        
        for i in splitToCharacters {
            print("Listing: ", i," of ",splitToCharacters.count ," is " ,splitToCharacters[i])
        }
       
        
    }

}
