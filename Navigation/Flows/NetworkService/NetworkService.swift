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
    func didUpdatePlanetInfo(_ service: NetworkService, info: PlanetModel)
    func didUpdateResidentInfo(_ service: NetworkService, info: [String])
    func didFailWithError(error: Error)
}


class NetworkService {
    
    var delegate: NetworkServiceDelegate?
    
    var residents: [String] = []
    
    var numberOfRows: Int {
        return residents.count
    }
    
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
    
    func createArrayOfData (data: Data) -> [TodoModel]? {
        var JSONdictionary: [[String: Any]]
        do {
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                print("Can't downcast data to array if dictionaries")
                return nil
            }
            JSONdictionary = dictionary
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        var returnArray: [TodoModel] = []
        for list in JSONdictionary {
            returnArray.append(TodoModel(from: list))
        }
        return returnArray
    }
    
    func performNewRequest (with urlString: String) {

        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let safeData = data {
                
                guard let list = self.createArrayOfData(data: safeData) else { return }
                let random = list.randomElement()
                self.delegate?.didUpdateTitleLabel(self, title: random?.title ?? "")
                
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
            }
        }
        task.resume()
    }
    
    func performPlanetRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let safeData = data {
                do {
                    let decoder = JSONDecoder()
                    let info = try decoder.decode(PlanetModel.self, from: safeData)
                    self.fetchResidents(from: info.residents)
                    self.delegate?.didUpdatePlanetInfo(self, info: info)
                } catch {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
            }
        }
        
        task.resume()
    }
    
    private func fetchResidents(from urls: [String]) {
        
        urls.forEach { url in
            
            guard let url = URL(string: url) else { return }
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let safeData = data {
                    do {
                        let decoder = JSONDecoder()
                        let resident = try decoder.decode(ResidentModel.self, from: safeData)
                        self.residents.append(resident.name)
                        self.delegate?.didUpdateResidentInfo(self, info: self.residents)
                    } catch {
                        self.delegate?.didFailWithError(error: error)
                        return
                    }
                }
            }
            task.resume()
        }
    }
    
    func textLabelForRow(index: Int) -> String {
        return residents[index]
    }
}
