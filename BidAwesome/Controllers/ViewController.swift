//
//  ViewController.swift
//  BidAwesome
//
//  Created by KENNETH BLUE on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
  
  let dm = DatabaseManager.shared
  var booksArray: [Book] = []
  var bookImages = [UIImage]()
  var indexPathArray = [IndexPath]()
  
  @IBOutlet weak var loginButton: UIBarButtonItem!
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBAction func didPressLoginButton(_ sender: UIBarButtonItem) {
    if sender.title == "Login" {
      let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
      let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
      present(viewController, animated: true, completion: nil)
    } else {
      do {
        try Auth.auth().signOut()
        loginButton.title = "Login"
      } catch {
        print("Could not log out")
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.barTintColor = UIColor(red:0.24, green:0.56, blue:0.30, alpha:1.0)
    title = "BidAwesome"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    loadBooks()
  }
  
  func loadBooks() {
    booksArray = []
    dm.getBooks(completionHandler: { books in
      for (index, book) in books.enumerated() {
        self.booksArray.append(book)
        self.dm.onBookPriceChanged(bookId: book.id!) { price in
          let cell = self.collectionView.cellForItem(at: self.indexPathArray[index]) as? CollectionViewCell
          cell?.currentBid.text = String(format:"$%.2f", price)
        }
      }
      self.collectionView.reloadData()
    })
    
    let user = Auth.auth().currentUser
    if user == nil {
      loginButton.title = "Login"
    } else {
      loginButton.title = "Logout"
    }
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return booksArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
    
    cell.displayContent()
    
    let currentBook = booksArray[indexPath.row]
    self.dm.getImage(for: currentBook.image) { image in
      cell.imageView.image = image
    }
    
    indexPathArray.append(indexPath)
    
    cell.titleLabel.text = currentBook.title
    cell.currentBid.text = String(format:"$%.2f", currentBook.bidPrice)
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
    let currentBook = booksArray[indexPath.row]
    let vc = DetailViewController.instanceFromStoryboard(book: currentBook)
    navigationController?.pushViewController(vc, animated: true)
  }
}

