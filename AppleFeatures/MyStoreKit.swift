//
//  MyStoreKit.swift
//  AppleFeatures
//
//  Created by rohitmakwana on 01/01/24.
//

import Foundation
import StoreKit

final class MyStoreKit: NSObject {
    
    static let shared = MyStoreKit()
    
    private override init() { }

    // ID is based on your requirements
    private let foodSubID = "life.food"
    private let monthlySubID = "myApp.sub.allaccess.monthly"
    private let yearlySubID = "myApp.sub.allaccess.yearly"
    private var products: [String: SKProduct] = [:]

    func fetchProducts() {
        let productIDs = Set([foodSubID, monthlySubID, yearlySubID])
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
    }

    func purchase(productID: String) {
        if let product = products[productID] {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }

    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    // Modify as per need
    
    /**
    There is two verifyReceiptURL for gathering the information from iTunes for both sandbox and live. The verifyReceiptURL API having 2 params. One is receipt-data which contains local receipt stored data and the second one is the password where you have to pass Shared Secret.
    **/
    func fetchReceiptData() {
        // Get the receipt if it's available
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
           FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
            
            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                print(receiptData)
                
                let receiptString = receiptData.base64EncodedString(options: [])
                
                // Read receiptData
                
                
            }
            catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
        }
    }
}

extension MyStoreKit: SKProductsRequestDelegate {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        response.invalidProductIdentifiers.forEach { product in
            print("Invalid: \(product)")
        }

        response.products.forEach { product in
            print("Valid: \(product)")
            products[product.productIdentifier] = product
        }
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error for request: \(error.localizedDescription)")
    }
}
