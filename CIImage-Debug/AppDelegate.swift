//
//  AppDelegate.swift
//  CIImage-Debug
//
//  Created by ios on 2024/9/18.
//

import UIKit
@_exported import MyBaseExtension
@_exported import MyControlView

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = UINavigationController(rootViewController: TabViewController())
        window.makeKeyAndVisible()
        let mirror = Mirror(reflecting: CIBokehBlur.self)
        for child in mirror.children {
            let type = type(of: child.value)
            if type == Int.self {
                
            }
        }
        return true
    }
}

