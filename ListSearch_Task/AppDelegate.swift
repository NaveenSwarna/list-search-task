//
//  AppDelegate.swift
//  ListSearch_Task
//
//  Created by Admin on 12/13/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = UINavigationController(rootViewController: MovieViewController())
		window?.makeKeyAndVisible()
		return true
	}

}

