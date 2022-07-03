//
//  CouponsViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 03/07/2022.
//

import UIKit

class CouponsViewController: UIViewController {

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var couponCodeField: TextFieldPadding!
    
    var draftOrder: DraftOrder?
    var couponVerified: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        couponVerified = false
        totalPriceLabel.text = draftOrder?.totalPrice
    }
    
    @IBAction func verifyCoupon(_ sender: Any) {
        
        if (couponCodeField.text == draftOrder?.appliedDiscount?.title) && !couponVerified! {
            
            // calculate new total after discount
            let discountedValue  = (1 - (draftOrder?.appliedDiscount?.value ?? 0)/100) * (Float(totalPriceLabel.text ?? "") ?? 0)
            
            // Update total price
            totalPriceLabel.text = [discountedValue.description,  SettingsViewModel.settingsCells[1].settingValue].compactMap{$0}.joined(separator: " ")
            
            // Notify verified
            couponVerified = true
            Helper.displayMessage(message: "Coupon Code Verified", messageError: false)
            
            // Hide Verfiy button
            if let sender = sender as? RoundedButton {
                sender.isHidden = true
            }
 
        } else {
            Helper.displayMessage(message: "Coupon Code not valid", messageError: true)
        }
    }
    @IBAction func continueToPayment(_ sender: Any) {
    }
    
}
