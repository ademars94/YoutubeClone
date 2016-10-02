//
//  Video.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/29/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import Foundation

class Video: SafeJsonObject {
  
  var thumbnail_image_name: String?
  var title: String?
  var number_of_views: NSNumber?
  var uploadDate: Date?
  var duration: NSNumber?
  
  var channel: Channel?
  
  override func setValue(_ value: Any?, forKey key: String) {
    if key == "channel" {
      
      let channelDictionary = value as! [String: AnyObject]
      let channel = Channel()
      
      channel.setValuesForKeys(channelDictionary)
      self.channel = channel
      
    } else  {
      super.setValue(value, forKey: key)
    }
  }
  
  init(videoDictionary: [String: Any]) {
    super.init()
    setValuesForKeys(videoDictionary)
  }
  
}
