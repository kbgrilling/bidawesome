//
//  LoginViewController.swift
//  BidAwesome
//
//  Created by Jay Strawn on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var logoView: UIView!

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  
  @IBAction func selectedSegmentDidChange(_ sender: Any) {
  }
  
  override func viewDidLoad() {
    logoView.layer.cornerRadius = logoView.frame.size.height / 2
  }
  
}
