//
//  WalutomatView.swift
//  SpekulantBar
//
//  Created by Piotr Bzymek on 07/07/15.
//  Copyright (c) 2015 XtremeRR. All rights reserved.
//

import Cocoa


class WalutomatView: NSView {

    @IBOutlet weak var walutomatLogo: NSImageView!
    @IBOutlet weak var sellRate: NSTextField!
    @IBOutlet weak var buyRate: NSTextField!

    func update(rates: KantorExchangeRate) {
        sellRate.stringValue = "Sell: \(rates.sellRate)"
        buyRate.stringValue = "Buy: \(rates.buyRate)"
        let logo = NSImage(named: "WalutomatLogo")
        walutomatLogo.image = logo
    }
    
}
