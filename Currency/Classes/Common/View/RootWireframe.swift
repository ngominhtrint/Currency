//
//  RootWireframe.swift
//  Currency
//
//  Created by TriNgo on 8/31/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe: NSObject {
    
    func showRootViewController(_ viewController: UIViewController, inWindow: UIWindow) {
        let navigationController =  navigationControllerFromWindow(window: inWindow)
        navigationController.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(window: UIWindow) -> UINavigationController {
        let navigationController = window.rootViewController as! UINavigationController
        return navigationController
    }
}
