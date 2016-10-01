//
//  SettingsLauncher.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/30/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class Setting {
  let name: String
  let imageName: String
  
  init(name: String, imageName: String) {
    self.name = name
    self.imageName = imageName
  }
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  let darkViewOverlay: UIView = {
    let dvo = UIView()
    dvo.backgroundColor = UIColor(white: 0, alpha: 0.5)
    dvo.alpha = 0
    return dvo
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.white
    return cv
  }()
  
  let settings: [Setting] = {
    return [
      Setting(name: "Settings", imageName: "gear-icon"),
      Setting(name: "Terms & Privacy Policy", imageName: "lock-icon"),
      Setting(name: "Send Feedback", imageName: "feedback-icon"),
      Setting(name: "Help", imageName: "help-icon"),
      Setting(name: "Switch Account", imageName: "user-icon-alt"),
      Setting(name: "Cancel", imageName: "x-icon")
    ]
  }()
  
  let cellId = "cellId"
  
  override init() {
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  func showSettings() {
    if let window = UIApplication.shared.keyWindow {
      darkViewOverlay.frame = window.frame
      darkViewOverlay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      let height: CGFloat = 200
      let y = window.frame.height - height
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
      window.addSubview(darkViewOverlay)
      window.addSubview(collectionView)
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.darkViewOverlay.alpha = 1
        self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }, completion: nil)
    }
  }
  
  func handleDismiss() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
      self.darkViewOverlay.alpha = 0
      if let window = UIApplication.shared.keyWindow {
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }
    }, completion: nil)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return settings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
    
    let setting = settings[indexPath.row]
    cell.setting = setting
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 48)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
