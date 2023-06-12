//
//  PomoFocusApp.swift
//  PomoFocus
//
//  Created by Mayank Gupta on 23/05/23.
//

import SwiftUI

@main
struct PomoFocusApp: App {
    
    @StateObject private var purchaseManager = PurchaseManager()
    
    var body: some Scene {
        WindowGroup {
            PaywallView()
                .environmentObject(purchaseManager)
                .task {
                    await purchaseManager.updatePurchasedProducts()
                }
        }
    }
}
