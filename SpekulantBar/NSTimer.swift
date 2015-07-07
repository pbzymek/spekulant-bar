//
//  NSTimer.swift
//  SpekulantBar
//
//  Created by Piotr Bzymek on 06/07/15.
//  Copyright (c) 2015 XtremeRR. All rights reserved.
//

import Foundation

private class NSTimerActor {
    var block: () -> ()
    
    init(block: () -> ()) {
        self.block = block
    }
    
    dynamic func fire() {
        block()
    }
}

extension NSTimer {
    convenience init(_ intervalFromNow: NSTimeInterval, block: () -> ()) {
        let actor = NSTimerActor(block: block)
        self.init(timeInterval: intervalFromNow, target: actor, selector: "fire", userInfo: nil, repeats: false)
    }
    
    convenience init(every interval: NSTimeInterval, block: () -> ()) {
        let actor = NSTimerActor(block: block)
        self.init(timeInterval: interval, target: actor, selector: "fire", userInfo: nil, repeats: true)
    }
//    
//    class func schedule(intervalFromNow: NSTimeInterval, block: () -> ()) -> NSTimer {
//        let timer = NSTimer(intervalFromNow, block)
//        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
//        return timer
//    }
//    
//    class func schedule(every interval: NSTimeInterval, block: () -> ()) -> NSTimer {
//        let timer = NSTimer(every: interval, block)
//        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
//        return timer
//    }
}