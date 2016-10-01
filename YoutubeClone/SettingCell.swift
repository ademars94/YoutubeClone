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
      nameLabel.text = setting?.name.rawValue
      
      if let imageName = setting?.imageName {
        print(imageName)
        icon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
      }
    }
  }
  
  let nameLabel: UILabel = {
    let l = UILabel()
    l.text = "Setting"
    l.textColor = UIColor.darkGray
    l.font = UIFont.systemFont(ofSize: 14)
    return l
  }()
  
  let icon: UIImageView = {
    let i = UIImageView()
    i.image = UIImage(named: "gear-icon")?.withRenderingMode(.alwaysTemplate)
    i.tintColor = UIColor.darkGray
    i.contentMode = .scaleAspectFill
    return i
  }()
  
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
      nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
      icon.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
    }
  }
  
  override func setupViews() {
    super.setupViews()
    addSubview(icon)
    addSubview(nameLabel)
    
    addConstraintsWithFormat("H:|-8-[v0(28)]-16-[v1]|", views: icon, nameLabel)
    addConstraintsWithFormat("V:[v0(28)]", views: icon)
    addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
    
    addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
  
}
