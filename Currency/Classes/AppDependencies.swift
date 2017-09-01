//
//  AppDependencies.swift
//  Currency
//
//  Created by TriNgo on 8/31/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    
    var converterWireFrame = ConverterWireFrame()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        converterWireFrame.presentConverterModule(fromView: window)
    }
    
    func configureDependencies() {
        let rootWireframe = RootWireframe()
        
        //Converter
        let converterPresenter = ConverterPresenter()
        let converterAPIDataManager = ConverterAPIDataManager()
        let converterInteractor = ConverterInteractor()
        
        converterInteractor.presenter = converterPresenter
        converterInteractor.APIDataManager = converterAPIDataManager
        
        converterPresenter.interactor = converterInteractor
        converterPresenter.wireframe = converterWireFrame
        
        converterWireFrame.rootWireframe = rootWireframe
        converterWireFrame.presenter = converterPresenter
    }
}
