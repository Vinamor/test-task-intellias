//
//  DataManager.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

class DataManager {
    
  // Changed this property to public to be able to test this code
    static var path = "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"
    
    func fetchQuotes(completionHandler: @escaping (Result<[Quote], Error>) -> Void) {
      guard let url = URL(string: DataManager.path) else {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        completionHandler(.failure(error))
        return
      }
      
      let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
          completionHandler(.failure(error))
          return
        }
        
        // Check the HTTP response status code
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])
          completionHandler(.failure(error))
          return
        }
        
        guard let data = data else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty data"])
          completionHandler(.failure(error))
          return
        }
        
        do {
          let decoder = JSONDecoder()
          let users = try decoder.decode([Quote].self, from: data)
          completionHandler(.success(users))
        } catch {
          completionHandler(.failure(error))
        }
      }
      
      task.resume()
    }
    
}
