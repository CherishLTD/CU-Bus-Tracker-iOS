//
//  SingletonInfo.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/18/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation

class SingletonInfo {
    class var sharedInstance: SingletonInfo {
        struct Static {
            static var instance: SingletonInfo?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = SingletonInfo()
        }
        
        return Static.instance!
}
