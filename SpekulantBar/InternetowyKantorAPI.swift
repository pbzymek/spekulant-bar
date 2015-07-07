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

