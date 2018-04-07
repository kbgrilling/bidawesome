//
//  ViewController.swift
//  BidAwesome
//
//  Created by KENNETH BLUE on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  var books: [Book] = []
  
  override func viewDidLoad() {
		super.viewDidLoad()
    navigationController?.navigationBar.barTintColor = UIColor(red:0.24, green:0.56, blue:0.30, alpha:1.0)
    title = "BidAwesome"
	}
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
    
    cell.displayContent()
    
    cell.layer.borderColor = UIColor.lightGray.cgColor
    cell.layer.borderWidth = 1
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = view.frame.size.height * 0.40
    let width = view.frame.size.width * 0.50
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = DetailViewController.instanceFromStoryboard()
    navigationController?.pushViewController(vc, animated: true)
  }
}

