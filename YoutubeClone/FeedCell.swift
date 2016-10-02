//
//  FeedCell.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 10/1/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
  
  let collectionView: UICollectionView = {
    let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    cv.backgroundColor = .white
    return cv
  }()

  override func setupViews() {
    super.setupViews()
    backgroundColor = .darkGray
    
    addSubview(collectionView)
    addConstraintsWithFormat("H:|[v0]|", views: collectionView)
    addConstraintsWithFormat("V:|[v0]|", views: collectionView)
  }

}
