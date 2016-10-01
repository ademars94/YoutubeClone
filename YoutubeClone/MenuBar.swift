//
//  MenuBar.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/29/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  // Lazy allows initialization of self before datasource and delegate are declared
  lazy var collectionView: UICollectionView  = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  let cellId = "menuBarCellId"
  let imageNames = ["home-icon", "fire-icon", "playlist-icon", "user-icon"]
  
  // Variable is used to change the horizontal position of the bar
  var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    addSubview(collectionView)
    addConstraintsWithFormat("H:|[v0]|", views: collectionView)
    addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    
    // Select first item in menu bar
    let selectedIndexPath = IndexPath(item: 0, section: 0)
    collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    
    setupHorizontalBar()
  }
  
  func setupHorizontalBar() {
    let horizontalBarView = UIView()
    horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(horizontalBarView)
    
    horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
    horizontalBarLeftAnchorConstraint?.isActive = true
    
    horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
    cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
    cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width / 4, height: frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Get x value depending on which item is selected times one fourth of the view width
    let x = CGFloat(indexPath.item) * self.frame.width / 4
    self.horizontalBarLeftAnchorConstraint?.constant = x
    
    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.layoutIfNeeded()
    }, completion: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class MenuCell: BaseCell {
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    return iv
  }()
  
  override var isHighlighted: Bool {
    didSet {
      imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
  }
  
  override var isSelected: Bool {
    didSet {
      imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
  }
  
  override func setupViews() {
    addSubview(imageView)
    addConstraintsWithFormat("H:[v0(24)]", views: imageView)
    addConstraintsWithFormat("V:[v0(24)]", views: imageView)
    
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
}
