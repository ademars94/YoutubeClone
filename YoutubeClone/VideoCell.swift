//
//  VideoCell.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/29/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  func setupViews() {
    // This method is always overridden
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class VideoCell: BaseCell {
  
  // Will set cell attributes when video property gets set
  var video: Video? {
    didSet {
      titleLabel.text = video?.title
      
      setupThumbnailImage()
      setupProfileImage()
      
      if let channelName = video?.channel?.name, let viewCount = video?.number_of_views {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        subtitleTextView.text = "\(channelName) • \(numberFormatter.string(from: viewCount)!) - 2 years ago"
      }
      
      // Measure the title text
      let size = CGSize(width: frame.width - 84, height: 1000)
      let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
      if let title = video?.title {
        let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17)], context: nil)
        if estimatedRect.size.height > 21 {
          titleLabelHeightConstraint?.constant = 44
        } else {
          titleLabelHeightConstraint?.constant = 20
        }
      }
    }
  }
  
  var titleLabelHeightConstraint: NSLayoutConstraint?
  
  let thumbnailImageView: CustomImageView = {
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "default-thumbnail-image")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let userProfileImageView: CustomImageView = {
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "question-mark-icon")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Generic YouTube Video"
    label.numberOfLines = 2
    return label
  }()
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
    textView.text = "Default • 0 - 0 years ago"
    textView.textColor = UIColor.lightGray
    return textView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    return view
  }()
  
  func setupThumbnailImage() {
    if let thumbnailImageUrl = video?.thumbnail_image_name {
      thumbnailImageView.loadImageUsing(urlString: thumbnailImageUrl)
    }
  }
  
  
  func setupProfileImage() {
    if let profileImageUrl = video?.channel?.profile_image_name {
      userProfileImageView.loadImageUsing(urlString: profileImageUrl)
    }
  }
  
  override func setupViews() {
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
    addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-38-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
    
    // titleLabel Constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    
    titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
    addConstraint(titleLabelHeightConstraint!)
    
    // subtitleTextView Constraints
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
  }
}
