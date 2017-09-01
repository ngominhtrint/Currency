//
//  ConverterItem.swift
//  Currency
//
//  Created by TriNgo on 8/31/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

struct ConverterItem {
    
    var currencyName: String
    var country: String
    var code: String
    var symbol: String
    var amount: String
    var convertedAmount: String
    var convertedList: [ConverterItem]
    var isFreshLoad: Bool
    
    init(currencyName: String, country: String, code: String, symbol: String, amount: String) {
        self.currencyName = currencyName
        self.country = country
        self.code = code
        self.symbol = symbol
        self.amount = amount
        self.convertedAmount = self.amount
        self.isFreshLoad = false
        self.convertedList = []
    }
}
