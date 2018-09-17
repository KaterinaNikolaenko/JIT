//
//  ApplicationRouter.swift
//  JIT
//
//  Created by Katerina on 17.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
import UIKit

final class ApplicationRouter {
    
//    static var currentViewController: UIViewController? {
//        if let currentNavigationController = currentNavigationController {
//            return currentNavigationController.topViewController
//        } else if let currentCenterVC = AppDelegate.shared.window?.rootViewController as? SlideMenuController {
//            return currentCenterVC.mainViewController
//        } else {
//            return AppDelegate.shared.window?.rootViewController
//        }
//    }
    
    static var currentNavigationController: UINavigationController? {
        if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.selectedViewController as? UINavigationController
        } else {
            return rootViewController as? UINavigationController
        }
    }
    
    static var rootViewController: UIViewController? {
        get {
            return AppDelegate.shared.window?.rootViewController
        }
        set {
            setWithTransition(newValue, animation: .transitionCrossDissolve, duration: 0.3, completion: nil)
        }
    }
}

// MARK: - Setting actions
extension ApplicationRouter {
    
//    static func setInitialScreen(_ completion: (() -> Void)? = nil) {
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var vc:UIViewController
//        
//        if UserDefaults.standard.bool(forKey: "showMainScreenFirst"){
//            vc = storyboard.instantiateInitialViewController()!
//        } else {
//            vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
//        }
//        
//        setWithTransition(vc, animation: .transitionCrossDissolve, completion: completion)
//    }
    
    static func setWithTransition(_ rootViewController: UIViewController?, animation: UIViewAnimationOptions, duration: Double = 0.5, completion: (() -> Void)?) {
        
        guard let window = AppDelegate.shared.window else {
            completion?()
            return
        }
        
        UIView.transition(with: window, duration: duration, options: animation, animations: {
            window.rootViewController = nil
            window.rootViewController = rootViewController
        }, completion: { (_) in
            completion?()
        })
    }
}


