//
//  CollectionViewCell.swift
//  BidAwesome
//
//  Created by Jay Strawn on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var currentBid: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  func displayContent() {
    titleLabel.text = "Book Title"
    currentBid.text = "$35.50"
    imageView.image = UIImage(named: "placeholder")
    
  }
}
