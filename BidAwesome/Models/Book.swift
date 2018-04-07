//
//  Book.swift
//  BidAwesome
//
//

import Foundation


class Book {
	let title: String
	let authors: Array<String>
	let bidPrice: Double
	let image: String
	let language: String
	let editor: String
	let description: String
	let id: String?
	
	init(title: String, authors: [String], bidPrice: Double, image: String, language: String, editor: String, description: String, id: String?) {
		self.title = title
		self.authors = authors
		self.bidPrice = bidPrice
		self.image = image
		self.language = language
		self.editor = editor
		self.description = description
		self.id = id ?? nil
	}
	
}
