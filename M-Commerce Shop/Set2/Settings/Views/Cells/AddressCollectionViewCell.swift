//
//  AddressCollectionViewCell.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    
    static let identifier = "AddressCollectionViewCell"
    
    var delegate: AddressesCellDelegate!

    var address: Address?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBAction func deleteAddress(_ sender: Any) {
        delegate.didTapDeleteButton(address: address!)
    }
}
