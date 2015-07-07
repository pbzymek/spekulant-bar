//
//  StatusMenuController.swift
//  SpekulantBar
//
//  Created by Piotr Bzymek on 06/07/15.
//  Copyright (c) 2015 XtremeRR. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, KantorAPIDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var kantorAliorView: KantorAliorView!
    @IBOutlet weak var internetowyView: InternetowyKantorView!
    @IBOutlet weak var walutomatView: WalutomatView!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1) // NSVariableStatusItemLength
    
    var kantorApi: KantorAliorAPI!
    var aliorMenuItem: NSMenuItem!
    var timer: NSTimer!
    
    var internetowyApi: InternetowyKantorAPI!
    var internetowyMenuItem: NSMenuItem!

    var walutomatApi: WalutomatAPI!
    var walutomatMenuItem: NSMenuItem!

    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.setTemplate(true)
        statusItem.image = icon
        statusItem.title = "N/A"
        statusItem.menu = statusMenu
        

        kantorApi = KantorAliorAPI(delegate: self)
        aliorMenuItem = statusMenu.itemWithTitle("Kantor Alior")
        aliorMenuItem.view = kantorAliorView

        internetowyApi = InternetowyKantorAPI(delegate: self)
        internetowyMenuItem = statusMenu.itemWithTitle("Internetowy Kantor")
        internetowyMenuItem.view = internetowyView

        walutomatApi = WalutomatAPI(delegate: self)
        walutomatMenuItem = statusMenu.itemWithTitle("Walutomat")
        walutomatMenuItem.view = walutomatView

        timer = NSTimer(timeInterval: 10.0, target: self, selector: "updateRates:", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        updateRates(timer)
    }

    func kantorDidUpdate(rates: KantorExchangeRate) {
        if let kantorAliorItem = self.statusMenu.itemWithTitle("Kantor Alior") {
            kantorAliorItem.title = rates.description
        }
        
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }

    func updateRates(timer: NSTimer) {
        kantorApi.fetchRates() { rates in
            self.kantorAliorView.update(rates)
            self.statusItem.title = rates.buyRate
        }
        internetowyApi.fetchRates() { rates in
            self.internetowyView.update(rates)
        }
        walutomatApi.fetchRates() { rates in
            self.walutomatView.update(rates)
        }
    }
}
