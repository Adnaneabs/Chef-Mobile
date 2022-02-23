//
//  Chef_MobileApp.swift
//
//
//  Created by Adnane El Abbas on 14/02/2022.
//

import SwiftUI
import Firebase

@main

struct Chef_MobileApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = ConnexionViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
class AppDelegate : NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

