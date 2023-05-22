//
//  SceneDelegate.swift
//  CineMatic
//
//  Created by Bartosz Szych on 21/05/2023.
//

import UIKit
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: HomeController())
        self.window = window
        self.window?.makeKeyAndVisible()
        
        print("DEBUG PRINT: Cache total size - ", SDImageCache.shared.diskCache.totalSize())
        
        SDImageCache.shared.config.maxDiskAge = 1000000 * 200
    }
    
}
