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
  
  private let db = Firestore.firestore()
  
  private let bookCollection: CollectionReference
  
  init() {
    bookCollection = db.collection("items")
  }
  
  //  func getItem(for id: String, completionHandler: @escaping (_ doc: DocumentSnapshot?, _ err: Error?) -> Void) {
  //    let item = itemCollection.document(id)
  //    item.getDocument { doc, err in
  //      completionHandler(doc, err)
  //    }
  // }
  
  func addBook(for id: String, book: Book) {
    bookCollection.document(id).setData([
      "authors": book.authors,
      "bidPrice": book.bidPrice,
      "description": book.description,
      "editor": book.editor,
      "language": book.language,
      "platform": book.platform,
      "title": book.title
      ])
  }
  
  func getBooks() -> [Book] {
    var books = [Book]()
    bookCollection.getDocuments { doc, err in
      for docData in (doc?.documents)! {
        let bookData = docData.data()
        let book = Book(
          title: bookData["title"] as! String,
          authors: bookData["authors"] as! [String],
          bidPrice: bookData["bidPrice"] as! Double,
          platform: bookData["platform"] as! String,
          image: "",
          language: bookData["language"] as! String,
          editor: bookData["editor"] as! String,
          description: bookData["description"] as! String,
          id: docData.documentID)
        books.append(book)
      }
    }
    return books
  }
}



