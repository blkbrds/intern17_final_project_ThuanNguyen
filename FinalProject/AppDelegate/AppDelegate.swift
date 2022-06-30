//
//  AppDelegate.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import UIKit
import SVProgressHUD

let HUD = SVProgressHUD.self
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navi = UINavigationController(rootViewController: BaseTabBarController())
        window?.rootViewController = navi
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        return true
    }
}
