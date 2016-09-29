//
//  HomeController.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/28/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Home"
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
}

class VideoCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.gray
    return imageView
  }()
  
  let userProfileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.lightGray
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = UIColor.lightGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = UIColor.lightGray
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.darkGray
    return view
  }()
  
  func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    // Horizontal Constraints
    addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
    addConstraintsWithFormat("H:|-16-[v0(44)]|", views: userProfileImageView)
    addConstraintsWithFormat("H:|[v0]|", views: separatorView)
    
    // Vertical Constraints
    addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
    
    // titleLabel Constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    
    // subtitleTextView Constraints
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    
//    addConstraintsWithFormat("V:[v0(20)]", views: titleLabel)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
      options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    
  }
}

