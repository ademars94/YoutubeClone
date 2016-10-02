//
//  NetworkManager.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 10/1/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
  
  static let shared = NetworkManager()
  
  func fetchFeedFor(urlString: String, completion: @escaping ([Video]) -> ()) {
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if error != nil {
        print(error)
        return
      }
      do {
        if let unwrappedData = data, let jsonObjects = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: Any]] {
          DispatchQueue.main.async {
            completion(jsonObjects.map({ return Video(videoDictionary: $0) })) // Creates dictionary of Videos and runs completion block using that array
          }
        }
      } catch let jsonError {
        print(jsonError)
      }
      
      }.resume()
  }
  
}
