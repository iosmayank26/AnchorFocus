//
//  PomoFocusApp.swift
//  PomoFocus
//
//  Created by Mayank Gupta on 23/05/23.
//

import SwiftUI
import Glassfy

@main
struct PomoFocusApp: App {
    
    var body: some Scene {
        WindowGroup {
            PaywallView()
                .onAppear() {
                    PurchaseManager.shared.configure()
                }
        }
    }
}
