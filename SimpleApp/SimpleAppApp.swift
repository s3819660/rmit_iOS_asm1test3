/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Phuoc Nhu Phuc
  ID: 3819660
  Created  date: 26/07/2022
  Last modified: 07/08/2022
  Acknowledgement:
    - https://rickandmortyapi.com
    - https://thehappyprogrammer.com/custom-list-in-swiftui
    - https://firebase.google.com/docs/firestore/quickstart
    - https://stackoverflow.com/questions/62741851/how-to-add-placeholder-text-to-texteditor-in-swiftui
    - https://github.com/twostraws/simple-swiftui/tree/main/SimpleNews
*/

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
