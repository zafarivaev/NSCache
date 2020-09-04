//
//  AppDelegate.swift
//  CachingImages
//
//  Created by Zafar on 9/3/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = PhotosViewController(
            collectionViewLayout: PhotosCollectionViewLayout()
        )
        window?.makeKeyAndVisible()
        
        return true
    }

}

