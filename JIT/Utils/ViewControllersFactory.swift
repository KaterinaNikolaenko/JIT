//
//  ViewControllersFactory.swift
//  JIT
//
//  Created by Katerina on 17.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
import UIKit

class ViewControllersFactory {
    
    static func getTerminals() -> UINavigationController {
        
        let storyboard = UIStoryboard(name: Constants.Storyboards.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllers.terminalsViewController) as! TerminalsViewController
        let navig = BaseNavigationController()
        navig.viewControllers = [viewController]
        return navig
    }
    
    static func getSendData() -> UINavigationController {
        
        let storyboard = UIStoryboard(name: Constants.Storyboards.main, bundle: nil)
        let terminalsVC = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllers.terminalsViewController) as! TerminalsViewController
        let sendDataVC = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllers.sendDataViewController) as! SendDataViewController
        
        let navig = BaseNavigationController()
        navig.viewControllers = [terminalsVC, sendDataVC]
        return navig
    }
}
