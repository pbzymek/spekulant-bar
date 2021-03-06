//
//  KantorAliorView.swift
//  SpekulantBar
//
//  Created by Piotr Bzymek on 06/07/15.
//  Copyright (c) 2015 XtremeRR. All rights reserved.
//

import Cocoa

class KantorAliorView: NSView {

    @IBOutlet weak var buyRate: NSTextField!
    @IBOutlet weak var sellRate: NSTextField!
    @IBOutlet weak var aliorLogo: NSImageView!


    func update(rates: CurrencyExchangeRate) {
        sellRate.stringValue = "Sell: \(rates.sellRate)"
        buyRate.stringValue = "Buy: \(rates.buyRate)"
        let logo = NSImage(named: "aliorLogo")
        aliorLogo.image = logo
    }
}
