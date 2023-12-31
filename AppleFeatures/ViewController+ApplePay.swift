//
//  ViewController+ApplePay.swift
//  AppleFeatures
//
//  Created by rohitmakwana on 31/12/23.
//

import UIKit
import PassKit

extension ViewController {
    
    func initPayment() {
        let paymentItem = PKPaymentSummaryItem.init(label: "Test Product", 
                                                    amount: NSDecimalNumber(value: 50.5))
        
        let paymentNetworks = [PKPaymentNetwork.amex, .discover, .masterCard, .visa, .quicPay]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            request.currencyCode = "USD"
            request.countryCode = "US"
            request.merchantIdentifier = "merchant.com.product-store" // change as per your need
            request.merchantCapabilities = PKMerchantCapability.capability3DS
            request.supportedNetworks = paymentNetworks
            request.paymentSummaryItems = [paymentItem]
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                displayAlert(title: "Error", message: "Unable to present Apple Pay authorization.")
                return
            }
            
            paymentVC.delegate = self
            present(paymentVC, animated: true, completion: nil)
        }
        else {
            displayAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
        }
    }
}

// PKPaymentAuthorizationViewControllerDelegate
extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
        displayAlert(title: "Success!", message: "The Apple Pay transaction was complete.")
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, 
                                            didAuthorizePayment payment: PKPayment,
                                            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void)
    {
    }
}

