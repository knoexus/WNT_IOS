//
//  AppDelegate.swift
//  WNT
//
//  Created by AD on 07/12/2019.
//  Copyright © 2019 AD. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
//        DispatchQueue.main.async {
//            FirebaseApp.configure()
//            if Auth.auth().currentUser != nil {
//                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let tabBarController = mainStoryboard.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
//                    as? TabBarController
//                self.window = UIWindow(frame: UIScreen.main.bounds)
//                self.window?.rootViewController = tabBarController
//                self.window?.makeKeyAndVisible()
//            }
//        }
        
//        DispatchQueue.main.async {
//            FirebaseApp.configure()
//            if Auth.auth().currentUser != nil {
//                if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController) as? TabBarController {
//                        if let window = self.window, let rootViewController = window.rootViewController {
//                            self.window = UIWindow(frame: UIScreen.main.bounds)
//                            var currentController = rootViewController
//                            while let presentedController = currentController.presentedViewController {
//                                currentController = presentedController
//                            }
//                            currentController.present(controller, animated: true, completion: nil)
//                        }
//                    }
//            }
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

