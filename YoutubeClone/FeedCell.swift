//
//  FeedCell.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 10/1/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  lazy var collectionView: UICollectionView = {
    let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    cv.alwaysBounceVertical = true
    cv.backgroundColor = .white
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  var videos: [Video]?
  
  let cellId = "cellId"

  override func setupViews() {
    super.setupViews()
    backgroundColor = .darkGray
    
    addSubview(collectionView)
    addConstraintsWithFormat("H:|[v0]|", views: collectionView)
    addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    
    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    
    fetchVideos()
  }
  
  // ========================
  // MARK: Networking Methods
  // ========================
  
  func fetchVideos() {
    NetworkManager.shared.fetchFeedFor(urlString: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") { (videos: [Video]) in
      self.videos = videos
      self.collectionView.reloadData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
    
    cell.video = videos?[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // Get 16:9 ratio, accounting for 16px margins and added view heights
    let height = (frame.width - 32) * (9 / 16) + 96
    return CGSize(width: frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  


}
