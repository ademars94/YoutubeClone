//
//  HomeController.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/28/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let feedCellId = "feedCellId"
  let trendingCellId = "trendingCellId"
  let subscriptionsCellId = "subscriptionsCellId"
  let titles = ["Home", "Trending", "Subscriptions", "Account"]
  
  lazy var titleLabel: UILabel = {
    let l = UILabel()
    l.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: self.view.frame.height)
    return l
  }()
  
  lazy var menuBar: MenuBar = {
    let mb = MenuBar()
    mb.homeController = self
    return mb
  }()
  
  lazy var settingsLauncher: SettingsLauncher = {
    let launcher = SettingsLauncher()
    launcher.homeController = self
    return launcher
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.isTranslucent = false
    
    setupCollectionView()
    setupMenuBar()
    setupNavigationBar()
  }
  
  // ========================
  // MARK: View Setup Methods
  // ========================
  
  func setupCollectionView() {
    
    if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .horizontal
      flowLayout.minimumLineSpacing = 0
    }
    
    collectionView?.backgroundColor = UIColor.white
//    collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
    collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
    collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellId)
    
    
    collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0) // Compensate for menu bar height
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0) // Compensate for menu bar height
    
    collectionView?.isPagingEnabled = true
  }
  
  private func setupNavigationBar() {
    let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "more-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    
    titleLabel.text = "Home"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 18)
    
    navigationItem.titleView = titleLabel
    navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
  }
  
  private func setupMenuBar() {
    navigationController?.hidesBarsOnSwipe = true
    
    let redView = UIView()
    redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    
    // redView removes space on navbar slide up
    view.addSubview(redView)
    view.addConstraintsWithFormat("H:|[v0]|", views: redView)
    view.addConstraintsWithFormat("V:[v0(50)]", views: redView)
    
    view.addSubview(menuBar)
    view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
    view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
    
    menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
  }
  
  // ===============================
  // MARK: Settings Launcher Methods
  // ===============================
  
  func handleSearch() {
    print("Searching...")
  }
  
  func handleMore() {
    settingsLauncher.showSettings()
  }
  
  func showControllerFor(setting: Setting) {
    let settingViewController = UIViewController()
    
    settingViewController.navigationItem.title = setting.name.rawValue
    settingViewController.view.backgroundColor = UIColor.white
    
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    navigationController?.pushViewController(settingViewController, animated: true)
  }
  
  // ========================
  // MARK: ScrollView Methods
  // ========================
  
  private func setTitleFor(index: Int) {
    titleLabel.text = titles[index]
    navigationItem.titleView = titleLabel
  }
  
  func showViewAt(menuIndex: Int) {
    let indexPath = IndexPath(item: menuIndex, section: 0)
    
    setTitleFor(index: menuIndex)
    
    collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let viewIndex = targetContentOffset.pointee.x / view.frame.width
    let indexPath = IndexPath(item: Int(viewIndex), section: 0)
    
    setTitleFor(index: indexPath.item)
    
    menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
  }
  
  // ============================
  // MARK: CollectionView Methods
  // ============================
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier: String
    
    switch indexPath.item {
      case 1: identifier = trendingCellId
      case 2: identifier = subscriptionsCellId
      default: identifier = feedCellId
    }
    
    return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height - 50)
  }
  
}

