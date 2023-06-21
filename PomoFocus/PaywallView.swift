//
//  PaywallView.swift
//  PomoFocus
//
//  Created by Mayank Gupta on 12/06/23.
//

import SwiftUI
import Glassfy

struct PaywallView: View {
    
    @State private var products: [Glassfy.Sku] = []
    @State private var hasUnlockedPro: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            if hasUnlockedPro {
                ContentView()
            } else {
                Text("Products")
                ForEach(products, id: \.self) { sku in
                    Button {
                        Task {
                            if try await PurchaseManager.shared.purchase(sku: sku, plan: Premium(rawValue: sku.productId) ?? .monthly_premium) {
                                hasUnlockedPro = true
                            }
                        }
                    } label: {
                        Text("\(sku.product.price) - \(sku.product.localizedTitle)")
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
            if let sku = await PurchaseManager.shared.getProduct() {
                products = PurchaseManager.shared.products
            }
        }
    }
}


struct PaywallView_Previews: PreviewProvider {
    static var previews: some View {
        PaywallView()
    }
}
