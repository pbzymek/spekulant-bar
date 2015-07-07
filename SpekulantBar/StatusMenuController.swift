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
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1) // NSVariableStatusItemLength
    
    var kantorApi: KantorAliorAPI!
    var ratesMenuItem: NSMenuItem!
    var timer: NSTimer!
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.setTemplate(true)
        statusItem.image = icon
        statusItem.title = "Test title"
        statusItem.menu = statusMenu
        

        kantorApi = KantorAliorAPI(delegate: self)
        ratesMenuItem = statusMenu.itemWithTitle("Kantor Alior")
        ratesMenuItem.view = kantorAliorView
        
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

    @IBAction func updateClicked(sender: NSMenuItem) {
//        updateRates()
    }

    func updateRates(timer: NSTimer) {
        kantorApi.fetchRates() { rates in
            self.kantorAliorView.update(rates)
            self.statusItem.title = rates.buyRate
        }
    }
}
