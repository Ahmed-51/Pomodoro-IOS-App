//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/9/22.
//

import SwiftUI
import Firebase
@main
struct PomodoroApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
