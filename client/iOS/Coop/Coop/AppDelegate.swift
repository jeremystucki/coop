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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationsRouter = LocationsRouter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let rootViewController = UINavigationController(rootViewController: locationsRouter.viewController)
        window = UIWindow(frame: UIScreen.main.bounds)

        if UIDevice.current.userInterfaceIdiom == .phone {
            window!.rootViewController = rootViewController
        }

        if UIDevice.current.userInterfaceIdiom == .pad {
            let splitViewController = UISplitViewController()
            splitViewController.viewControllers.append(rootViewController)
            splitViewController.preferredDisplayMode = .allVisible

            window!.rootViewController = splitViewController
        }

        window!.makeKeyAndVisible()

        return true
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        locationsRouter.showMenus(forLocation: Location(name: shortcutItem.localizedTitle))
    }

    func applicationWillResignActive(_ application: UIApplication) {
        var shortcutItems = [UIApplicationShortcutItem]()
        for location in Configuration.favoriteLocations {
            shortcutItems.append(UIApplicationShortcutItem(type: "favoriteLocation", localizedTitle: location))
        }

        UIApplication.shared.shortcutItems = shortcutItems
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
