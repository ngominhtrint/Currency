//
//  CurrencyListItem.swift
//  Currency
//
//  Created by TriNgo on 9/1/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

struct CurrencyListItem {
    
    var currencyName: String
    var country: String
    var code: String
    var symbol: String
    
    init(currencyName: String, country: String, code: String, symbol: String) {
        self.currencyName = currencyName
        self.country = country
        self.code = code
        self.symbol = symbol
    }
}
