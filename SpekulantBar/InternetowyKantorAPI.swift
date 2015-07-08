//
//  InternetowyKantorAPI.swift
//  SpekulantBar
//
//  Created by Piotr Bzymek on 06/07/15.
//  Copyright (c) 2015 XtremeRR. All rights reserved.
//

import Cocoa

class InternetowyKantorAPI: NSObject {

    let BASE_URL = "https://internetowykantor.pl/cms/currency/?"
    
    var delegate: KantorAPIDelegate?
    var lastUpdate: Int64
    
    init(delegate: KantorAPIDelegate) {
        self.delegate = delegate
        lastUpdate = Int64(NSDate().timeIntervalSince1970)
    }
    
    func fetchRates(success: (CurrencyExchangeRate) -> Void) {
        let session = NSURLSession.sharedSession()
        lastUpdate = Int64(NSDate().timeIntervalSince1970)
        let url = NSURL(string: "\(BASE_URL)last-update=\(lastUpdate)")
        let task = session.dataTaskWithURL(url!) { data, response, error in
            if let rates = self.ratesFromJSONData(data) {
                success(rates)
            }
        }
        task.resume()
    }
    
    func ratesFromJSONData(data: NSData) -> CurrencyExchangeRate? {
        var err: NSError?
        typealias JSONDict = [String:AnyObject]
        
        if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            var buyRate = ((json["rates"] as! NSDictionary)["USD"] as! NSDictionary)["buying_rate"] as! String
            var sellRate = ((json["rates"] as! NSDictionary)["USD"] as! NSDictionary)["selling_rate"] as! String

            var exchangeRate = CurrencyExchangeRate(
                sellRate: sellRate,
                buyRate: buyRate,
                sourceCurrencyName: "US Dollar",
                sourceCurrencyCode: "USD",
                destinationCurrencyName: "Polski Złoty",
                destinationCurrencyCode: "PLN"
            )
            
            return exchangeRate
        }
        return nil
    }
    
}

