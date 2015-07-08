//
//  Api.swift
//  SpekulantBar
//
//  Created by Piotr Bzymek on 07/07/15.
//  Copyright (c) 2015 XtremeRR. All rights reserved.
//

import Cocoa

class WalutomatAPI: NSObject {
   let BASE_URL = "https://panel.walutomat.pl/api/v1/best_offers.php?curr1=USD&curr2=PLN"
    
    var delegate: KantorAPIDelegate?
    
    init(delegate: KantorAPIDelegate) {
        self.delegate = delegate
    }
    
    func fetchRates(success: (CurrencyExchangeRate) -> Void) {
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: BASE_URL)
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
        
        if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &err) as? JSONDict {
            var exchangeRate = CurrencyExchangeRate(
                sellRate: json["sell"] as! String,
                buyRate: json["buy"] as! String,
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



