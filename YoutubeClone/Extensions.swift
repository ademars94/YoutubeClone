
//
//  Extensions.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/29/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

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

extension UIImageView {
  func loadImageUsing(urlString: String) {
    let url = URL(string: urlString)
    
    image = nil
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if error != nil {
        print(error)
        return
      }
      
      DispatchQueue.main.async {
        self.image = UIImage(data: data!)
      }
    }.resume()
  }
}
