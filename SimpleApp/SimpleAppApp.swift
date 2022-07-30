//
//  SimpleAppApp.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 26/07/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

let db = Firestore.firestore()

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct SimpleAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
