//
//  DetailView.swift
//  BidAwesome
//
//  Created by Jay Strawn on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit

class DetailViewController: ViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bidLabel: UILabel!
  @IBOutlet weak var bidsLabel: UILabel!
  @IBOutlet weak var aboutLabel: UILabel!
  @IBOutlet weak var platformLabel: UILabel!
  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var editorLabel: UILabel!
  
  //var book: Book!
  
  override func viewDidLoad() {
    //titleLabel.text = bookTitle
    imageView.image = UIImage(named: "placeholder")
  }
  
  // you can pass in your model here
  static func instanceFromStoryboard() -> DetailViewController {
    let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    return viewController
  }
  
}
