//
//  CurrencyListPresenter.swift
//  Currency
//
//  Created by TriNgo on 9/1/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

class CurrencyListPresenter: CurrencyListPresenterProtocol {
    
    weak var view: CurrencyListViewProtocol?
    var interactor: CurrencyListInteractorInputProtocol?
    var wireframe: CurrencyListWireFrameProtocol?
    
    init() { }
    
    func updateView() {
        interactor?.getCurrencyList()
    }
    
    func selectCurrencyListItem(_ currencyListItem: CurrencyListItem) {
        wireframe?.dismissCurrencyListWithSelectedData(currencyListItem)
    }
}

extension CurrencyListPresenter: CurrencyListInteractorOutputProtocol {
    func fetchedCurrencyList(_ currencyList: [CurrencyListItem]) {
        view?.reloadTableViewWithCurrencyList(currencyList)
    }
}
