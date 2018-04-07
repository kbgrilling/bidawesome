//
//  DetailView.swift
//  BidAwesome
//
//  Created by Jay Strawn on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: ViewController {
	
	
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var bidLabel: UILabel!
	@IBOutlet weak var aboutLabel: UILabel!
	@IBOutlet weak var platformLabel: UILabel!
	@IBOutlet weak var languageLabel: UILabel!
	@IBOutlet weak var editorLabel: UILabel!
	
	@IBAction func bidButtonWasPressed(_ sender: UIButton) {
		let user = Auth.auth().currentUser
		let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
		if user != nil {
			print("go to bid page")
			let viewController = mainStoryboard.instantiateViewController(withIdentifier: "BidViewController") as! BidViewController
			present(viewController, animated: true, completion: nil)
		} else {
			print("go to login page")
			let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
			present(viewController, animated: true, completion: nil)
		}
	}
	var currentBook: Book!
	
	
	override func viewDidLoad() {
		imageView.image = UIImage(named: "placeholder")
		titleLabel.text = currentBook.title
		bidLabel.text = String(format:"$%.2f", currentBook.bidPrice)
		aboutLabel.text = currentBook.description
		platformLabel.text = "Platform: \(currentBook.platform)"
		languageLabel.text = "Language: \(currentBook.language)"
		editorLabel.text = "Editor \(currentBook.editor)"
		
	}
	
	// you can pass in your model here
	static func instanceFromStoryboard(book: Book) -> DetailViewController {
		let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
		let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
		viewController.currentBook = book
		return viewController
	}
	
	
}

