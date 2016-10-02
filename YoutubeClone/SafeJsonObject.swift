//
//  SafeJsonObject.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 10/2/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import Foundation

class SafeJsonObject: NSObject {
  
  override func setValue(_ value: Any?, forKey key: String) {
    if !self.responds(to: Selector(key)) {
      print("Class doesn't respond to selector \(key).")
      return
    }
    super.setValue(value, forKey: key)
  }
  
}
