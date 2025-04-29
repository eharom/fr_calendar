//
//  AppDelegate.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-09.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App started")
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(applicationWillResignActive),
                         name: UIApplication.willResignActiveNotification,
                         object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(applicationDidBecomeActive),
                         name: UIApplication.didBecomeActiveNotification,
                         object: nil)
        print(UIDevice.smallScreen)
        return true
    }
    
    @objc func applicationWillResignActive() {
        print("Will resign")
    }
    
    @objc func applicationDidBecomeActive() {
        print("Did become active")
    }
}

