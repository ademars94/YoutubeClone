//
//  SettingsLauncher.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/30/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
  
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

  
}
