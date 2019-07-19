//
//  MainVC.swift
//  CollectionViewPractice-01
//
//  Created by Koki Tabayashi on 7/19/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit

class MainVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let feedVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "notifications_selected"), selectedImage: #imageLiteral(resourceName: "add_button_deselected"), rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        viewControllers = [feedVC]
    }
    
    // construct navigation controllers
    func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // construct nav controller
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        // return nav controller
        return navController
    }
}
