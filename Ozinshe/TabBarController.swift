//
//  TabBarController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 18.11.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "TabBarColor")
        setTabs()
    }
    
    
    func setTabs(){
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let seacrhVC = UINavigationController(rootViewController: SearchViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "ProfileSelected"))
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "HomeSelected"))
        seacrhVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "SearchSelected"))
        favoritesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "FavoriteSelected"))
        
        setViewControllers([homeVC,seacrhVC,favoritesVC,profileVC], animated: false)
    }
}
