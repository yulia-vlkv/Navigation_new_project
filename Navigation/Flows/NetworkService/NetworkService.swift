//
//  NetworkService.swift
//  Navigation
//
//  Created by Iuliia Volkova on 04.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation


struct NetworkService {
    
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
}
