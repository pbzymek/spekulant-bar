//
//  InternetowyKantorView.swift
//  SpekulantBar
//
//  Created by Piotr Bzymek on 07/07/15.
//  Copyright (c) 2015 XtremeRR. All rights reserved.
//

import Cocoa

class InternetowyKantorView: NSView {

    @IBOutlet weak var internetowyLogo: NSImageView!
    @IBOutlet weak var sellRate: NSTextField!
    @IBOutlet weak var buyRate: NSTextField!
    
    func update(rates: KantorExchangeRate) {
        sellRate.stringValue = "Sell: \(rates.buyRate)"
        buyRate.stringValue = "Buy: \(rates.sellRate)"
        let logo = NSImage(named: "IKLogo")
        internetowyLogo.image = logo
    }
}
