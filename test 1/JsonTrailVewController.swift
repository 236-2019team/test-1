//
//  FileTableViewController.swift
//  test 1
//
//  Created by Administrator on 2/12/21.
//

import UIKit

class JsonTrailViewController: UIViewController {

    struct DemoData: Codable {
        let trailName: String
        let description: String
        let lengthMeters: Double
        let difficulty: String
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let localData = self.readLocalFile(forName: "TrailData") {
            self.parse(jsonData: localData)
        }
        
        let urlString = "https://raw.githubusercontent.com/programmingwithswift/ReadJSONFileURL/master/hostedDataFile.json"

        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }   //  end_loadJson
 
    }  //  end_viewDidLoad
    
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }  //  end_readLocal
    
   

    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(DemoData.self,from: jsonData)
            
            print("title: ", decodedData.trailName)
            print("description: ", decodedData.description)
            print("length: ",decodedData.lengthMeters)
            print("Difficulty: ",decodedData.difficulty)
            print("===================================")
        } catch {
            print("decode error")
        }
    }  //  end_parse
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    } //  end_loadJson
    
} //  end class
