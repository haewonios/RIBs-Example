//
//  AppDelegate.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/20.
//

import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let appComponent = AppComponent()
        let launchRouter = RootBuilder(dependency: appComponent).build()
        self.launchRouter = launchRouter
        launchRouter.launch(from: window)
        
        return true
    }
}
