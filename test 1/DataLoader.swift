//
//  DataLoader.swift
//  test 1
//
//  Created by Administrator on 2/13/21.
//

import Foundation

public class DataLoader{
    @published var TrailData=[TrailData]()
    
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "myTrail", "withExtension: "JSON"){
        
        // do catch in case of error
            do {
             let data = try Data(contentsOf)
            }
            catch {
            print(error)
            }
            
        }
    }  // end_load
}
