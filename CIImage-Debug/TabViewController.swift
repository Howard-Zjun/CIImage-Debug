//
//  TabViewController.swift
//  CIImage-Debug
//
//  Created by ios on 2024/9/20.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
    }
    
    func configTabBar() {
        let singleDebugVC = UINavigationController(rootViewController: SingleDebugViewController())
        singleDebugVC.tabBarItem.title = "单个调试"
        singleDebugVC.tabBarItem.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 14)], for: .normal)
        singleDebugVC.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor(hex: 0x3FA0FF)], for: .selected)
        singleDebugVC.tabBarItem.image = .init(named: "tab_icon_learn_nor")
        singleDebugVC.tabBarItem.selectedImage = .init(named: "tab_icon_learn_select")
        
        let combinedDebugVC = UINavigationController(rootViewController: <#T##UIViewController#>)
        combinedDebugVC.tabBarItem.title = "组合调试"
        combinedDebugVC.tabBarItem.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 14)], for: .normal)
        combinedDebugVC.tabBarItem.setBadgeTextAttributes([.foregroundColor : UIColor(hex: 0x3FA0FF)], for: .selected)
        combinedDebugVC.tabBarItem.image = .init(named: "tab_icon_voice_nor")
        combinedDebugVC.tabBarItem.selectedImage = .init(named: "tab_icon_voice_select")
        
        viewControllers = [singleDebugVC, combinedDebugVC]
    }
}
