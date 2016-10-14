//
//  AppDelegate.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if UserDefaults.standard.stringArray(forKey: "favoriteLocations") == nil {
            UserDefaults.standard.set([String](), forKey: "favoriteLocations")
        }

        window?.rootViewController = UINavigationController(rootViewController: LocationsRouter().viewController)
        window?.makeKeyAndVisible()

        return true
    }

    @objc func showSettings() {

    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        switch url.host {
        case "settings"?:
            showSettings()
        default:
            return false
        }

        return true
    }

}
