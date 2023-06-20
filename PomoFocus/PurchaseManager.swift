//
//  PurchaseManager.swift
//  PomoFocus
//
//  Created by Mayank Gupta on 12/06/23.
//

import Foundation
import Glassfy

enum Premium: String, CaseIterable {
    case monthly_premium
    case yearly_premium
    
    var sku: String {
        return rawValue
    }
}

class PurchaseManager {
    
    static let shared = PurchaseManager()
    let apiKeyValue = "b9571f39bb7b42889ee0a9b27257f9a2"
    var products: [Glassfy.Sku] = []
    
    
    func configure() {
        Glassfy.initialize(apiKey: apiKeyValue, watcherMode: false)
    }
    
    func checkPermissions() {
        Glassfy.permissions { permissions, error in
            guard let permissions = permissions, error == nil else { return }
            
            if permissions[Premium.monthly_premium.rawValue]?.isValid == true {
                //Do whatever you want here
            }
        }
    }
    
    func purchase(sku: Glassfy.Sku, plan: Premium) async -> Bool {
        do {
            let transaction = try await Glassfy.purchase(sku: sku)
            if transaction.permissions[plan.rawValue]?.isValid == true {
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
            for premium in Premium.allCases {
                let sku = try await Glassfy.sku(id: premium.rawValue)
                products.append(sku)
            }
            return products
        } catch {
            print(error.localizedDescription)
            return nil
            
        }
    }
    
}
