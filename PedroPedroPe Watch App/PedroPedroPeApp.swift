//
//  PedroPedroPeApp.swift
//  PedroPedroPe Watch App
//
//  Created by Victor Castro on 24/04/24.
//

import SwiftUI

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    func applicationDidBecomeActive() {
        print("La app de Watch entró en primer plano")
        NotificationCenter.default.post(name: Notification.Name("didBecomeActiveWatch"), object: nil)
    }
    
    func applicationWillResignActive() {
        print("La app de Watch entró en segundo plano")
        NotificationCenter.default.post(name: Notification.Name("willResignActiveWatch"), object: nil)
    }
    
    func applicationWillEnterForeground() {
        print("La app de Watch está entrando en primer plano")
        NotificationCenter.default.post(name: Notification.Name("WillEnterForegroundWatch"), object: nil)
    }
    
    func applicationWillTerminate() {
        print("La app de Watch está a punto de terminar")
        NotificationCenter.default.post(name: Notification.Name("WillTerminateWatch"), object: nil)

    }
}

@main
struct PedroPedroPe_Watch_AppApp: App {
        
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var extensionDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
