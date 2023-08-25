//
//  TmarkisApp.swift
//  Tmarkis
//
//  Created by Agang Dut on 8/20/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
    
    @main
    struct TmarkisApp: App {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        init() {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemRed
            UIPageControl.appearance().currentPageIndicatorTintColor = .yellow
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
            
        }
        var body: some Scene {
            WindowGroup {
                NavigationView {
                    ContentView()
                        .environmentObject(SessionStore())
            }
        }
    }
}
