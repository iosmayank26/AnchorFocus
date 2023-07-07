//
//  PurchaseManager.swift
//  PomoFocus
//
//  Created by Mayank Gupta on 12/06/23.
//

import Foundation
import Glassfy


class PurchaseManager {
    
    static let shared = PurchaseManager()
    let apiKeyValue = "b9571f39bb7b42889ee0a9b27257f9a2"
    var products: [Glassfy.Sku] = []
    
    
    func configure() {
        Glassfy.initialize(apiKey: apiKeyValue, watcherMode: false)
    }
    
    func hasPurchased() async -> Bool {
        do {
            let permissions = try await Glassfy.permissions()
            for product in products {
                if permissions[product.skuId]?.isValid == true {
                    return true
                }
            }
            return false
        } catch {
            print(error.localizedDescription)
            return false
        }

    }
    
    func purchase(sku: Glassfy.Sku) async -> Bool {
        do {
            let transaction = try await Glassfy.purchase(sku: sku)
            if transaction.permissions[sku.skuId]?.isValid == true {
                return true
            } else {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getProduct() async -> [Glassfy.Sku]? {
        do {
            let offerings = try await Glassfy.offerings()
            if let offering = offerings["premium"] {
                // display your offering's skus
                for sku in offering.skus {
                    products.append(sku)
                }
            }
            return products
        } catch {
            print(error.localizedDescription)
            return nil

        }
    }
    
    func restorePurchase() async -> Bool {
        do {
            let permissions = try await Glassfy.restorePurchases()
            for product in products {
                if permissions[product.skuId]?.isValid == true {
                    return true
                }
            }
            return false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
