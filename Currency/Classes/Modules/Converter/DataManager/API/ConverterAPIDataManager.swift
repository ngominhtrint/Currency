//
//  ConverterAPIDataManager.swift
//  Currency
//
//  Created by TriNgo on 8/31/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ConverterAPIDataManager: ConverterAPIDataManagerInputProtocol {
    
    init() { }
    
    func fetchCurrencyFromServerWithData(_ baseCurrencyCode: String, completion: ((AnyObject) -> Void)!, failed: ((AnyObject) -> Void)!) {
        Alamofire.request("http://api.fixer.io/latest?base=\(baseCurrencyCode)").responseJSON { response in
            print(String(describing: response.request?.description))
            if response.result.isSuccess {
                let jsonObject = JSON(data: response.data!)
                completion?(jsonObject as AnyObject)
            } else {
                failed?(response.result.error as AnyObject)
            }
        }
    }
}
