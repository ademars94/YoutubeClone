
//
//  Extensions.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/29/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

// MARK: Extensions

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
}

extension UIView {
  func addConstraintsWithFormat(_ format: String, views: UIView...) {
    var viewsDictionary = [String: UIView]()
    
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
  }
}

// MARK: Subclasses

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
  
  var imageUrlString: String?
  
  func loadImageUsing(urlString: String) {
    imageUrlString = urlString
    let url = URL(string: urlString)
    
    image = nil
    
    if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
      print("Loading from cache: \(self.imageUrlString!)")
      self.image = imageFromCache
      return
    }
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if error != nil {
        print(error)
        return
      }
      
      DispatchQueue.main.async {
        if self.imageUrlString == urlString {
          print("Loading from network: \(self.imageUrlString!)")
          
          let imageToBeCached = UIImage(data: data!)
          
          self.image = imageToBeCached
          
          imageCache.setObject(imageToBeCached!, forKey: urlString as NSString)
        }
      }
    }.resume()
  }
}
