//
//  PaymentViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 03/07/2022.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var paymentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var offlineSwitch: UISwitch!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var amountToPay: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func selectPayment(_ sender: Any) {
    }
    @IBAction func selectPayOffline(_ sender: Any) {
    }
    @IBAction func placeOrder(_ sender: Any) {
    }
    
}
