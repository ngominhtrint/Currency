//
//  CurrencyListInteractor.swift
//  Currency
//
//  Created by TriNgo on 9/1/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

class CurrencyListInteractor: CurrencyListInteractorInputProtocol {
    
    weak var presenter: CurrencyListInteractorOutputProtocol?
    var APIDataManager: CurrencyListAPIDataManagerInputProtocol?
    var localDataManager: CurrencyListLocalDataManagerInputProtocol?
    var currencyListLocalDataManager = CurrencyListLocalDataManger()
    
    init() {}
    
    func getCurrencyList() {
        let currencyListArray = currencyListLocalDataManager.loadCurrencyListArrayFromBundle()
        var currencyListItems = [CurrencyListItem]()
        
        for currency in currencyListArray {
            if (currency as? NSDictionary) != nil {
                let object = currency as? [String : Any]
                let currencyListItem = CurrencyListItem(currencyName: object!["name"] as! String,
                                                        country: object!["country"] as! String,
                                                        code: object!["code"] as! String,
                                                        symbol: object!["symbol"] as! String)
                currencyListItems.append(currencyListItem)
            }
        }
        
        self.presenter?.fetchedCurrencyList(currencyListItems)
    }
}
