//
//  DatabaseManager.swift
//  BidAwesome
//
//  Created by Brody Eller on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import Firebase

final class DatabaseManager {
  static let shared = DatabaseManager()
  
  private lazy var db = {
    Firestore.firestore()
  }()
  
  private lazy var storage = {
    Storage.storage()
  }()
  
  private lazy var bookCollection: CollectionReference = {
    db.collection("items")
  }()
  
  init() {
  }
    
  func addBook(for id: String, book: Book) {
    bookCollection.document(id).setData([
      "authors": book.authors,
      "bidPrice": book.bidPrice,
      "description": book.description,
      "editor": book.editor,
      "image": book.image,
      "language": book.language,
      "platform": book.platform,
      "title": book.title
      ])
  }
  
  func updateBidPrice(book: Book, bidPrice: Double) {
    bookCollection.document(book.id!).setData(["bidPrice": bidPrice], options: SetOptions.merge())
  }
  
  func getBooks(completionHandler: @escaping (_ books: [Book]) -> Void){
    var books = [Book]()
    bookCollection.getDocuments { doc, err in
      guard let docs = doc?.documents else { completionHandler([]); return }
      for docData in docs {
        let bookData = docData.data()
        let book = Book(
          title: bookData["title"] as! String,
          authors: bookData["authors"] as! [String],
          bidPrice: bookData["bidPrice"] as! Double,
          platform: bookData["platform"] as! String,
          image: bookData["image"] as! String,
          language: bookData["language"] as! String,
          editor: bookData["editor"] as! String,
          description: bookData["description"] as! String,
          id: docData.documentID)
        books.append(book)
      }
      completionHandler(books)
    }
  }
  
  func getImage(for location: String, completionHandler: @escaping (_ image: UIImage) -> Void) {
    let gsReference = storage.reference(forURL: location)
    gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let data = data {
        completionHandler(UIImage(data: data)!)
      } else {
        print("Error Occurred: \(error)")
      }
    }
  }
}



