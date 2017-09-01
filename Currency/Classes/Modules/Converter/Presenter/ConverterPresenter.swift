//
//  ConverterPresenter.swift
//  Currency
//
//  Created by TriNgo on 8/31/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation
import UIKit

class ConverterPresenter {
    weak var view: ConverterViewProtocol?
    var interactor: ConverterInteractorInputProtocol?
    var wireframe: ConverterWireFrameProtocol?
    
    init() { }
}

/**
 * Methods for communication VIEW -> PRESENTER
 */
extension ConverterPresenter: ConverterPresenterProtocol {
    func showCurrencyListView() {
        self.wireframe?.showCurrencyListViewController()
    }
    
    func loadView() {
        self.interactor?.initWithBaseCurrencyAndLoad()
    }
    
    func getCurrencyListWithData(_ baseConverterItem: ConverterItem) {
        self.interactor?.getCurrencyWithData(baseConverterItem)
    }
}

/**
 * Methods for communication INTERACTOR -> PRESENTER
 */
extension ConverterPresenter: ConverterInteractorOutputProtocol {
    func initWithBaseConverterItem(_ converterItem: ConverterItem) {
        self.view?.initWithBaseAndReload(currencyName: converterItem.currencyName, country: converterItem.country, code: converterItem.code, symbol: converterItem.symbol, amount: converterItem.amount)
    }
    
    func fetchedConvertedCurrency(_ convertedCurrency: [ConverterItem]) {
        if convertedCurrency.count == 0 {
            self.view?.noContentFromServer()
        } else {
            self.view?.reloadTableViewWithData(convertedCurrency)
        }
    }
}
