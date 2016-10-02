//
//  TrendingCell.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 10/1/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

  override func fetchVideos() {
    NetworkManager.shared.fetchFeedFor(urlString: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json") { (videos: [Video]) in
      self.videos = videos
      self.collectionView.reloadData()
    }
  }

}
