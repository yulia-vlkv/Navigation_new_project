//
//  NetworkService.swift
//  Navigation
//
//  Created by Iuliia Volkova on 04.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

protocol NetworkServiceDelegate {
    
    func didUpdateTitleLabel(_ service: NetworkService, title: String)
    
}


struct NetworkService {
    
    var delegate: NetworkServiceDelegate?
    
    static func performRequest (with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("The error occured: \(error.localizedDescription)")
                return
                
                // If no Internet connection, it prints:
                // "The error occured: The Internet connection appears to be offline."
            }
            if let safeData = data, let urlResponse = response as? HTTPURLResponse {
                let dataString = String(data: safeData, encoding: .utf8)
                print ("Data: \(dataString ?? "")")
                print ("Response code: \(urlResponse.statusCode)")
                print ("Response header fields: \(urlResponse.allHeaderFields)")
            }
        }
        task.resume()
    }
    
    func createArrayOfData (data: Data) -> [TodosModel]? {
        var JSONdictionary: [[String: Any]]
        do {
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                print("Can't downcast data to array if dictionaries")
                return nil
            }
            JSONdictionary = dictionary
        } catch {
            print("The error occured: \(error.localizedDescription)")
            return nil
        }
        var returnArray: [TodosModel] = []
        for list in JSONdictionary {
            returnArray.append(TodosModel(from: list))
        }
        return returnArray
    }
    
    func performNewRequest (with urlString: String) {

        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let safeData = data {
                
                guard let list = createArrayOfData(data: safeData) else { return }
                let random = list.randomElement()
                self.delegate?.didUpdateTitleLabel(self, title: random?.title ?? "")
                
                if let error = error {
                    print ("The error occured: \(error.localizedDescription)")
                    return
                }
            }
        }
       task.resume()
   }
}
