//
//  SettingCell.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 10/1/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
  
  var setting: Setting? {
    didSet {
      nameLabel.text = setting?.name
      
      if let imageName = setting?.imageName {
        print(imageName)
        icon.image = UIImage(named: imageName)
      }
    }
  }
  
  let nameLabel: UILabel = {
    let l = UILabel()
    l.text = "Setting"
    return l
  }()
  
  let icon: UIImageView = {
    let i = UIImageView()
    i.image = UIImage(named: "gear-icon")?.withRenderingMode(.alwaysTemplate)
    i.tintColor = UIColor.gray
    i.contentMode = .scaleAspectFill
    return i
  }()
  
  override func setupViews() {
    super.setupViews()
    addSubview(icon)
    addSubview(nameLabel)
    
    addConstraintsWithFormat("H:|-8-[v0(32)]-16-[v1]|", views: icon, nameLabel)
    addConstraintsWithFormat("V:[v0(32)]", views: icon)
    addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
    
    addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
  
}
