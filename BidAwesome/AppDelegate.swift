//
//  AppDelegate.swift
//  BidAwesome
//
//  Created by KENNETH BLUE on 4/6/18.
//  Copyright © 2018 Kenneth Blue. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
	GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
	GIDSignIn.sharedInstance().delegate = self
    return true
  }
	
	@available(iOS 11.0, *)
	func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
		-> Bool {
			return GIDSignIn.sharedInstance().handle(url,
													 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
													 annotation: [:])
	}
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
		// ...
		if let error = error {
			// ...
			print(error)
			return
		}
		
		guard let authentication = user.authentication else { return }
		let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
													   accessToken: authentication.accessToken)
		// ...
		print(credential)
	}
	
	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
		// Perform any operations when the user disconnects from app here.
		// ...
	}
}

