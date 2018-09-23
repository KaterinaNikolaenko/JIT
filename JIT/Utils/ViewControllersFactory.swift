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
}
