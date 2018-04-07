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
  
  private let itemCollection: CollectionReference
  
  init() {
    itemCollection = db.collection("items")
  }
  
  func getItem(for id: String, completionHandler: @escaping (_ doc: DocumentSnapshot?, _ err: Error?) -> Void) {
    let item = itemCollection.document(id)
    item.getDocument { doc, err in
      completionHandler(doc, err)
    }
  }
  
//  func addItem(for id: String, book: Book) {
//    itemCollection.document(id).setData([
//      "bidPrice": book.bid,
//      "description": book,
//      "editor": book.ide,
//      ])
//  }
  
//  func getItems() -> [Book] {
//    var books = [Book]()
//  }
  
}
