//
//  BidViewController.swift
//  BidAwesome
//
//  Created by Jay Strawn on 4/7/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit

class BidViewController: UIViewController {
  
  var dm = DatabaseManager.shared
  var currentBook: Book!
  static var amountEntered: Double!
  
  @IBOutlet weak var textView: UITextField!
	@IBOutlet weak var currentBidLabel: UILabel!
	
  @IBAction func didPlaceBid(_ sender: UIButton) {
    dm.updateBidPrice(book: currentBook, bidPrice: BidViewController.amountEntered)
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func didPressDismissButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    self.textView.becomeFirstResponder()
  }
  
  @objc func myTextFieldDidChange(_ textField: UITextField) {
    
    if let amountString = textField.text?.currencyInputFormatting() {
      textField.text = amountString
    }
    
  }
  
  static func instanceFromStoryboard(book: Book) -> BidViewController {
    let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "BidViewController") as! BidViewController
    viewController.currentBook = book
    
    return viewController
  }

}

extension String {
  
  func currencyInputFormatting() -> String {
    
    var number: NSNumber!
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currencyAccounting
    numberFormatter.currencySymbol = "$"
    
    var biddingAmount = self
    let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
    
    biddingAmount = regex.stringByReplacingMatches(in: biddingAmount, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
    let double = (biddingAmount as NSString).doubleValue
    number = NSNumber(value: (double / 100))
    
    BidViewController.amountEntered = number as! Double!
    
    return numberFormatter.string(from: number)!
  }
}

