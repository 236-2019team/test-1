//
//  ViewController.swift
//  test 1
//
//  Created by sophia adkins on 1/28/21.
//

import UIKit
import MapKit

class mapViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = DataLoader().generatedData
        
        print(data)
    }


}

