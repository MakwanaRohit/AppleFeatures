//
//  ViewController.swift
//  AppleFeatures
//
//  Created by rohitmakwana on 31/12/23.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func applePayAction(_ sender: UIButton) {
        initPayment()
    }
    
    
    @IBAction private func loginWithApple(_ sender: UIButton) {
        handleAuthorizationAppleID()
    }
    
    @IBAction private func inAppPurchaseAction(_ sender: UIButton) {
        MyStoreKit.shared.fetchProducts()
    }
}

