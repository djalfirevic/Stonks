//
//  AppDelegate.swift
//  Stonks
//
//  Created by Djuro on 3/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder {

    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - Private API
    
    /// Setup the root view controller.
    private func configureRootController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = RootViewController()
        
        self.window = window
    }

}

extension AppDelegate: UIApplicationDelegate {
    
    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        configureRootController()
        
        return true
    }
    
}
