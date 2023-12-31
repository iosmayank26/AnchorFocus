//
//  PaywallView.swift
//  PomoFocus
//
//  Created by Mayank Gupta on 12/06/23.
//

import SwiftUI
import StoreKit

struct PaywallView: View {
    
    @EnvironmentObject private var purchaseManager: PurchaseManager
    
    @State private var products: [Product] = []
    
    var body: some View {
        VStack(spacing: 20) {
            if purchaseManager.hasUnlockedPro {
                ContentView()
            } else {
                Text("Products")
                ForEach(purchaseManager.products) { product in
                    Button {
                        Task {
                            do {
                                try await purchaseManager.purchase(product)
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        Text("\(product.displayPrice) - \(product.displayName)")
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                }
                Button {
                    Task {
                        do {
                            try await AppStore.sync()
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Restore Purchases")
                }
            }
        }.task {
            Task {
                do {
                    try await purchaseManager.loadProducts()
                } catch {
                    print(error)
                }
            }
        }
    }
}


struct PaywallView_Previews: PreviewProvider {
    static var previews: some View {
        PaywallView()
    }
}
