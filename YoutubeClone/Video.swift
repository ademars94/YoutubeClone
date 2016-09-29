//
//  Video.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/29/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class Video: NSObject {
  
  var thumbnailImageName: String?
  var title: String?
  var viewCount: NSNumber?
  var uploadDate: Date?
  
  var channel: Channel?
  
}

class Channel: NSObject {
  
  var name: String?
  var profileImageName: String?
  
}
