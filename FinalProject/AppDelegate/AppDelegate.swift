//
//  AppDelegate.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import UIKit
import SVProgressHUD
import AVFAudio

let HUD = SVProgressHUD.self
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true)
            try session.setCategory(.playback, mode: .default, options: .defaultToSpeaker)
        } catch {
            print(error.localizedDescription)
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseTabBarController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}
