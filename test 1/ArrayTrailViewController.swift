//
//  ArrayTrailViewController.swift
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
        
        for mystring in splitToCharacters {
            print("Listing: ", myString," of ",splitToCharacters.count ," is " ,splitToCharacters[mystring])
        }
       
    } //  end_ViewDidLoad

}  //end_class
