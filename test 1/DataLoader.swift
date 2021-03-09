//
//  DataLoader.swift
//  test 1
//
//  Created by students on 2/13/21.
//

import Foundation

public class DataLoader {
    
    @Published var generatedData = [GeneratedData]()
    
    init() {
        load()
       // sort()
    }
    
    func load() {
        
        if let fileLocation = Bundle.main.url(forResource: "generated", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([GeneratedData].self, from: data)
                
                self.generatedData = dataFromJson
            }
            catch {
                print(error)
            }
        }
    }
    
 /*   func sort() {
        // might not work because trailName is not an int
        self.generatedData = self.generatedData.sorted(by: { $0.trailName < $1.trailName})
    }
 */
}
