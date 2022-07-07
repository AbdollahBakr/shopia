//
//  OrdersCell.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 07/07/2022.
//

import UIKit

class OrdersCell: UITableViewCell {
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var prderPriceLabel: UILabel!
    @IBOutlet weak var orderQtyLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(order:CustomerOrdersResult){
        createdAtLabel.text = order.created_at
    }

}
