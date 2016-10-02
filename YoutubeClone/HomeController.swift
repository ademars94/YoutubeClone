//
//  HomeController.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/28/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  private var videos: [Video]?
  private let cellId = "cellId"
  
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
    
    fetchVideos()
    
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
    collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: "cellId")
    collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0) // Compensate for menu bar height
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0) // Compensate for menu bar height
    
    collectionView?.isPagingEnabled = true
  }
  
  private func setupNavigationBar() {
    let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "more-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    
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
  
  // ========================
  // MARK: Networking Methods
  // ========================
  
  func fetchVideos() {
    NetworkManager.shared.fetchVideos { (videos: [Video]) in
      self.videos = videos
      self.collectionView?.reloadData()
    }
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
  
  func showViewAt(menuIndex: Int) {
    let indexPath = IndexPath(item: menuIndex, section: 0)
    collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let viewIndex = targetContentOffset.pointee.x / view.frame.width
    let indexPath = IndexPath(item: Int(viewIndex), section: 0)
    menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
  }
  
  // ============================
  // MARK: CollectionView Methods
  // ============================
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
  
  
  
//  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return videos?.count ?? 0
//  }
//  
//  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
//    
//    cell.video = videos?[indexPath.item]
//    
//    return cell
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    // Get 16:9 ratio, accounting for 16px margins and added view heights
//    let height = (view.frame.width - 32) * (9 / 16) + 96
//    return CGSize(width: view.frame.width, height: height)
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    return 0
//  }
//  
}

