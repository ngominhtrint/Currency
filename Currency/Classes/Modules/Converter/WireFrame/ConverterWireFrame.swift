//
//  ConverterWireFrame.swift
//  Currency
//
//  Created by TriNgo on 8/31/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation
import UIKit

let ConverterViewIdentifier = "ConverterView"

class ConverterWireFrame: ConverterWireFrameProtocol {
    
    var rootWireframe: RootWireframe?
    var converterView: ConverterView?
    
    var presenter: ConverterPresenterProtocol & ConverterInteractorOutputProtocol = ConverterPresenter()
    
    func presentConverterModule(fromView window: AnyObject) {
        let view = converterViewFromStoryboard()
        
        view.presenter = presenter
        presenter.view = view
        converterView = view
        rootWireframe?.showRootViewController(view, inWindow: window as! UIWindow)
    }
    
    func showCurrencyListViewController() {
        
    }
    
    func converterViewFromStoryboard() -> ConverterView {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ConverterViewIdentifier) as! ConverterView
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
