//
//  BaseTabBarController.swift
//  FinalProject
//
//  Created by thuan.nguyen on 15/06/2022.
//

import UIKit

final class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    // MARK: - Setup View Controller
    private func setupViewController() {
        let homeViewController = HomeViewController()
        let homeNavi = UINavigationController(rootViewController: homeViewController)
        homeNavi.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "ic-home-tabbar").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "ic-home-selected").withRenderingMode(.alwaysOriginal))

        let liveViewController = LiveViewController()
        let liveNavi = UINavigationController(rootViewController: liveViewController)
        liveNavi.tabBarItem = UITabBarItem(title: "Live", image: #imageLiteral(resourceName: "ic-live-tabbar").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "ic-live-selected").withRenderingMode(.alwaysOriginal))

        /* Favorites */
        let catchupViewController = CatchupViewController()
        let catchupNavi = UINavigationController(rootViewController: catchupViewController)
        catchupNavi.tabBarItem = UITabBarItem(title: "CatchupTV", image: #imageLiteral(resourceName: "ic-catchup-tabbar").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "ic-catchup-selected").withRenderingMode(.alwaysOriginal))

        /* Profile */
        let favouritesViewController = FavouritesViewController()
        let favouritesNavi = UINavigationController(rootViewController: favouritesViewController)
        favouritesNavi.tabBarItem = UITabBarItem(title: "Favourites", image: #imageLiteral(resourceName: "ic-vod-tabbar").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "ic-favourite-selected").withRenderingMode(.alwaysOriginal))
        let viewControllers = [homeNavi, liveNavi, catchupNavi, favouritesNavi]
        self.tabBar.tintColor = .systemCyan
        self.tabBar.backgroundColor = .systemFill
        self.viewControllers = viewControllers
    }
}
