//
//  AppDelegate.swift
//  Stormy
//
//  Created by Ethan Neff on 10/6/14.
//  Copyright (c) 2014 ethanneff. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        application.setStatusBarHidden(true, withAnimation: .None)
        
        return true
    }

}

