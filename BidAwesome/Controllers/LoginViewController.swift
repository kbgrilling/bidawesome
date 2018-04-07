//
//  LoginViewController.swift
//  BidAwesome
//
//  Created by Jay Strawn on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  
  @IBOutlet weak var logoView: UIView!

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  var register = true
  
  @IBAction func selectedSegmentDidChange(_ sender: Any) {
    register = !register
  }
  
  @IBAction func login(_ sender: Any) {
    guard let email = emailTextField.text else { return }
    guard let pwd = passwordTextField.text else { return }
    if register {
      Auth.auth().createUser(withEmail: email, password: pwd) { user, err in
        print("\(user?.displayName) Registered Successful")
        self.dismiss(animated: true, completion: nil)
      }
    } else {
      Auth.auth().signIn(withEmail: email, password: pwd) { user, err in
        print("\(user?.displayName) Login Successful")
        self.dismiss(animated: true, completion: nil)
      }
    }
  }
  
  override func viewDidLoad() {
    logoView.layer.cornerRadius = logoView.frame.size.height / 2
  }
  
}
