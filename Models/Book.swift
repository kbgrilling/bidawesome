//
//  Book.swift
//  BidAwesome
//
//

import Foundation


class Book {
	let title: String
	let authors: Array<String>
	let bid: Double
	let image: String
	let ide: String
	let id: String?
	
	init(title: String, authors: [String], bid: Double, image: String, ide: String, id: String?) {
		self.title = title
		self.authors = authors
		self.bid = bid
		self.image = image
		self.ide = ide
		self.id = id ?? nil
	}
	
}
