//
//  ConverterView.swift
//  Currency
//
//  Created by TriNgo on 8/31/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation
import UIKit
import Refresher
import GoogleMobileAds
import Mixpanel

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}

class ConverterView: UIViewController {
    
    var presenter: ConverterPresenterProtocol?
    var baseConverterItem : ConverterItem!
    
    @IBOutlet var mainTableView : UITableView!
    @IBOutlet var baseAmountTextField : UITextField!
    @IBOutlet var baseCountryImageView : UIImageView!
    @IBOutlet var baseCountryCodeLabel : UILabel!
    @IBOutlet var baseCountryNameLabel : UILabel!
    @IBOutlet var baseCurrencySymbolLabel : UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureView() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        navigationItem.title = "Currency Converter"
        self.addPullToRefresh()
        self.presenter?.loadView()
        
        //google ads
        bannerView.adUnitID = "ca-app-pub-4961045217927492/3331079163"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func addPullToRefresh() {
        let pacmanAnimator = PacmanAnimator(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 80))
        self.mainTableView.addPullToRefreshWithAction({ 
            self.baseConverterItem.isFreshLoad = true
            self.presenter?.getCurrencyListWithData(self.baseConverterItem)
        }, withAnimator: pacmanAnimator)
    }
    
    func convertAmountWithBaseValue(amount: String) {
        self.baseConverterItem.amount = amount
        self.baseConverterItem.isFreshLoad = false
        self.presenter?.getCurrencyListWithData(self.baseConverterItem)
    }
    
    func formatCurrency(_ string: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        let numberFromField = NSString(string: string).doubleValue
        let temp = formatter.string(from: NSNumber(value: numberFromField))
        return String(temp!.characters.dropFirst())
    }
    
    @IBAction func showCurrecnyList(sender: UIButton) {
        self.presenter?.showCurrencyListView()
    }
}

extension ConverterView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseConverterItem.convertedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier : String
        identifier = "cell"
        
        let cell:UITableViewCell = (self.mainTableView!.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as UITableViewCell)
        
        self.configureCellForTableView(tableView, withCell: cell, withIndexPath: indexPath)
        return cell
    }
    
    func configureCellForTableView(_ tableView: UITableView, withCell cell: UITableViewCell, withIndexPath indexPath: IndexPath) {
        if let converterItem = self.baseConverterItem.convertedList[safe: (indexPath as NSIndexPath).row] {
            let amountTextField:UITextField = cell.viewWithTag(222) as! UITextField
            let codeLabel:UILabel = cell.viewWithTag(223) as! UILabel
            let imageView:UIImageView = cell.viewWithTag(225) as! UIImageView
            let symbolLabel:UILabel = cell.viewWithTag(221) as! UILabel
            let countryNameLabel:UILabel = cell.viewWithTag(224) as! UILabel
            
            amountTextField.text = self.formatCurrency(converterItem.convertedAmount)
            codeLabel.text = converterItem.code
            symbolLabel.text = converterItem.symbol
            countryNameLabel.text = "1 \(self.baseConverterItem.code) = \( NSString(format : "%.4f", Double(converterItem.amount)!) as String) \(converterItem.currencyName)"
            imageView.image = UIImage.init(named: "\(converterItem.country).png")
        }
    }
}

extension ConverterView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return bannerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let converterItem = self.baseConverterItem.convertedList[safe: (indexPath as NSIndexPath).row] {
            self.baseConverterItem.amount = baseAmountTextField.text!
            Mixpanel.mainInstance().track(event: "MainScreenCurrencySelection", properties: ["Code" : converterItem.code, "CurrencyName" : converterItem.currencyName])
            self.initWithBaseAndReload(currencyName: converterItem.currencyName, country: converterItem.country, code: converterItem.code, symbol: converterItem.symbol, amount: converterItem.amount)
        }
    }
}

extension ConverterView: ConverterViewProtocol {
    func initWithBaseAndReload(currencyName: String, country: String, code: String, symbol: String, amount: String) {
        self.baseConverterItem = ConverterItem(currencyName: currencyName, country: country, code: code, symbol: symbol, amount: amount)
        
        self.baseCountryImageView.image = UIImage.init(named: "\(self.baseConverterItem.country).png")
        self.baseCountryCodeLabel.text = self.baseConverterItem.code
        self.baseCountryNameLabel.text = self.baseConverterItem.country
        self.baseCurrencySymbolLabel.text = self.baseConverterItem.symbol
        self.baseConverterItem.amount = self.baseAmountTextField.text!
        
        self.mainTableView.startPullToRefresh()
    }
    
    func reloadTableViewWithData(_ converterItems: [ConverterItem]) {
        self.mainTableView.stopPullToRefresh()
        
        self.baseConverterItem.convertedList = converterItems
        self.mainTableView.reloadData()
        self.baseAmountTextField.becomeFirstResponder()
    }
    
    func noContentFromServer() {
        self.mainTableView.stopPullToRefresh()
    }
}

extension ConverterView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let filtered = string.components(separatedBy: NSCharacterSet(charactersIn: "0123456789.").inverted).joined(separator: "")
        if string == filtered {
            let txtAfterUpdate: NSString = textField.text! as NSString
            self.convertAmountWithBaseValue(amount: txtAfterUpdate.replacingCharacters(in: range, with: string))
            return true
        } else {
            return false
        }
    }
}
