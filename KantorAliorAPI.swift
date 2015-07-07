//
//  KantorAliorAPI.swift
//  SpekulantBar
//
//  Created by Piotr Bzymek on 06/07/15.
//  Copyright (c) 2015 XtremeRR. All rights reserved.
//

import Cocoa

struct KantorExchangeRate {
    var sellRate: String
    var buyRate:  String
    
    var description: String {
        return "Sell Rate: \(sellRate) | Buy Rate: \(buyRate)"
    }
}

protocol KantorAPIDelegate {
    func kantorDidUpdate(rates: KantorExchangeRate)
}

class KantorAliorAPI: NSObject {
    let BASE_URL = "http://kantor.aliorbank.pl/chart/USD/json"

    var delegate: KantorAPIDelegate?
    
    init(delegate: KantorAPIDelegate) {
        self.delegate = delegate
    }
    
    func fetchRates(success: (KantorExchangeRate) -> Void) {
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: BASE_URL)
        let task = session.dataTaskWithURL(url!) { data, response, error in
            if let rates = self.ratesFromJSONData(data) {
               success(rates)
            }
        }
        task.resume()
    }
    
    func ratesFromJSONData(data: NSData) -> KantorExchangeRate? {
        var err: NSError?
        typealias JSONDict = [String:AnyObject]
        
        if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &err) as? JSONDict {
            var exchangeRate = KantorExchangeRate(
                sellRate: json["actualSellRate"] as! String,
                buyRate: json["actualBuyRate"] as! String
            )
            
            return exchangeRate
        }
        return nil
    }
    
}

