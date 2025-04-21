//
//  FRCalendarApp.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-03-19.
//

import SwiftUI
import SwiftData

@main
struct FRCalendarApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Reminder.self)
    }
}

