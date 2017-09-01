//
//  CurrencyListLocalDataManager.swift
//  Currency
//
//  Created by TriNgo on 9/1/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

class CurrencyListLocalDataManger: CurrencyListLocalDataManagerInputProtocol {
    
    init() { }
    
    func loadCurrencyListArrayFromBundle() -> NSArray {
        let mainBundle = Bundle.main
        let path = mainBundle.path(forResource: "CountryData", ofType: "plist")
        return NSArray(contentsOfFile: path!) as NSArray!
    }
}
