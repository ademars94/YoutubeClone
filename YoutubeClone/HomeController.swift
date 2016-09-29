//
//  HomeController.swift
//  YoutubeClone
//
//  Created by Alex DeMars on 9/28/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
//  var videos: [Video] = {
//    
//    // Channels
//    var obamaChannel = Channel()
//    obamaChannel.name = "BarackObamaOfficial"
//    obamaChannel.profileImageName = "obama-profile-image"
//    
//    var bidenChannel = Channel()
//    bidenChannel.name = "JoeBidenOfficial"
//    bidenChannel.profileImageName = "biden-profile-image"
//    
//    // Videos
//    var redVideo = Video()
//    redVideo.title = "Red Video with Arbitrarily Long Title to Demonstrate Text Wrapping"
//    redVideo.thumbnailImageName = "generic-video-thumbnail-red"
//    redVideo.channel = obamaChannel
//    redVideo.viewCount = 1876324203
//    
//    var orangeVideo = Video()
//    orangeVideo.title = "Orange Video"
//    orangeVideo.thumbnailImageName = "generic-video-thumbnail-orange"
//    orangeVideo.channel = bidenChannel
//    orangeVideo.viewCount = 2846384982
//    
//    var yellowVideo = Video()
//    yellowVideo.title = "Yellow Video"
//    yellowVideo.thumbnailImageName = "generic-video-thumbnail-yellow"
//    yellowVideo.channel = obamaChannel
//    yellowVideo.viewCount = 923877949
//    
//    var greenVideo = Video()
//    greenVideo.title = "Green Video"
//    greenVideo.thumbnailImageName = "generic-video-thumbnail-green"
//    greenVideo.channel = bidenChannel
//    greenVideo.viewCount = 887384709
//    
//    var blueVideo = Video()
//    blueVideo.title = "Blue Video"
//    blueVideo.thumbnailImageName = "generic-video-thumbnail-blue"
//    blueVideo.channel = obamaChannel
//    blueVideo.viewCount = 2783879409
//    
//    return [redVideo, orangeVideo, yellowVideo, greenVideo, blueVideo]
//  }()
  
  var videos: [Video]?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchVideos()
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    titleLabel.text = "Home"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    navigationItem.titleView = titleLabel
    
    navigationController?.navigationBar.isTranslucent = false
    
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0) // Compensate for menu bar height
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0) // Compensate for menu bar height
    
    setupMenuBar()
    setupNavBarButtons()
  }
  
  let menuBar: MenuBar = {
    let mb = MenuBar()
    return mb
  }()
  
  func setupNavBarButtons() {
    let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "more-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
  }
  
  func handleMore() {
    print("Showing more...")
  }
  
  func handleSearch() {
    print("Searching...")
  }
  
  func fetchVideos() {
    let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if error != nil {
        print(error)
        return
      }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        
        self.videos = [Video]()
        
        for dictionary in json as! [[String: AnyObject]] {
          let video = Video()
          video.title = dictionary["title"] as? String
          video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
          self.videos?.append(video)
        }
        self.collectionView?.reloadData()
        
      } catch let jsonError {
        print(jsonError)
      }
      
    }.resume()
  }
  
  private func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
    view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
    
    cell.video = videos?[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // Get 16:9 ratio, accounting for 16px margins and added view heights
    let height = (view.frame.width - 32) * (9 / 16) + 96
    return CGSize(width: view.frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
}

