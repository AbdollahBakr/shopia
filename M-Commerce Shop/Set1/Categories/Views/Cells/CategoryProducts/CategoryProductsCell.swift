//
//  CategoryProductsCell.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 06/07/2022.
//

import UIKit
import Kingfisher

class CategoryProductsCell: UITableViewCell {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: RoundedCornersLeftImage!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    func configureCell(product:ProductsResult) {
        
        productTitleLabel.text = product.title
        if let url = URL(string: product.image?.src ?? "") {
            let placeholder = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(with: url,placeholder: placeholder,options: options)
            for price in product.variants ?? [] {
                productPriceLabel.text = "  \(price.price ?? "")"
            }
        }
    }

    
}
