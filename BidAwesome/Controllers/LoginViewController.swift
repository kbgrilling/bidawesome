//
//  LoginViewController.swift
//  BidAwesome
//
//  Created by Jay Strawn on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
  
  @IBOutlet weak var logoView: UIView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginBtn: UIButton!
  @IBOutlet weak var signInButton: GIDSignInButton!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  @IBAction func didPressDismissButton(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    switch segmentedControl.selectedSegmentIndex {
    case 0:
      loginBtn.titleLabel?.text = "Register"
    case 1:
      loginBtn.titleLabel?.text = "Login"
    default:
      print("Segmented Control Not at 1 or 2 Somehow")
    }
  }
  
  @IBAction func didPressLoginButton(_ sender: UIButton) {
    guard let email = emailTextField.text else { return }
    guard let pwd = passwordTextField.text else { return }
	let alert = UIAlertController(title: "Error", message: "You have an error!", preferredStyle: .alert)
	let okAction = UIAlertAction(title: "ok", style: .default)
	alert.addAction(okAction)
    if segmentedControl.selectedSegmentIndex == 0 {
      Auth.auth().createUser(withEmail: email, password: pwd) { user, err in
		if err != nil {
			print("err Description \(String(describing: err?.localizedDescription)) -- err code: \(err!._code)")
			if let errCode = AuthErrorCode(rawValue: err!._code) {
				/// need to make a password algorithum, username rules, and display for errs
				switch errCode {
				case .invalidEmail:
					print("Invalid Email")
					self.title = "Try Again"
					alert.message = "Oh no, email address problem. Review your email address and make sure it is correct! "
					self.present(alert, animated: true, completion: nil)
				case .emailAlreadyInUse:
					alert.message = "Oh no, the email address is already in use by another account. If this is your email address you may already have an account."
					self.present(alert, animated: true, completion: nil)
				case .weakPassword:
					print("Password is not strong")
					alert.message = "Oh no, Password problem. Your password needs to be stronger at least 6 characters! "
					self.present(alert, animated: true, completion: nil)
				default:
					print("There is an err!")
					alert.message = "Oh no, there was an err.  Please check your connection and try again. "
					
					self.present(alert, animated: true, completion: nil)
					/*errAlert = UIAlertController(title: "err Occured",
					message: "There is an err!",
					preferredStyle: .alert)*/
				}
			}
		}
		if user != nil {
			user?.sendEmailVerification() {
				err in
				print(err?.localizedDescription as Any)
			}
			Auth.auth().signIn(withEmail: email, password: pwd)
			self.dismiss(animated: true, completion: nil)
		}
//        print("\(user?.displayName) Registered Successful")
//        self.dismiss(animated: true, completion: nil)
      }
    } else  {
      Auth.auth().signIn(withEmail: email, password: pwd) { user, err in
		if err != nil {
			//print("error Description \(String(describing: err?.localizedDescription)) -- error code: \(err!._code)")
			alert.message = "Your email and password do not match please try again."
			let forgotPasswordAction = UIAlertAction(title: "Forgot Password", style: .default) { action in
				Auth.auth().sendPasswordReset(withEmail: email) { err in
					if err != nil {
						if let errorCode = AuthErrorCode(rawValue: err!._code) {
							switch errorCode {
							case .invalidSender:
								print("Invalid Email")
								self.title = "Try Again"
								alert.message = "Cannot locate email address. Is this your email address?"
								self.present(alert, animated: true, completion: nil)
							default:
								print("There is an error!")
								alert.message = "Oh no, there was an error.  Please check your connection and try again."
								self.present(alert, animated: true, completion: nil)
							}
						}
					}
				}
			}
			alert.addAction(forgotPasswordAction)
			self.present(alert, animated: true, completion: nil)
		} else {
			self.dismiss(animated: true, completion: nil)
		}
		}
    }
  }
  
  @IBAction func googleLogin(_ sender: Any) {
    GIDSignIn.sharedInstance().signIn()
  }
  
  override func viewDidLoad() {
    logoView.layer.cornerRadius = logoView.frame.size.height / 2
	
	GIDSignIn.sharedInstance().uiDelegate = self
	

  }
  
}
