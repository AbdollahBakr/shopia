//
//  CartCollectionViewCell.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cartItemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var itemCountStepper: UIStepper!
    
    static let identifier = "CartCollectionViewCell"
    var delegate: CartCellDelegate!
    var cartItem: Edge?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.contentView.isUserInteractionEnabled = false
    }
    
    @IBAction func stepItemCounter(_ sender: UIStepper) {
        print(sender.value.description)
        itemCountLabel.text = Int(sender.value).description
    }
    @IBAction func deleteCartItem(_ sender: Any) {
        delegate.didTapDeleteButton(item: cartItem!)
    }
    @IBAction func stepperClicked(_ sender: UIStepper) {
        print("touched")
    }
    
}
