//
//  BrandProductsCell.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 03/07/2022.
//

import UIKit
import Kingfisher

class BrandProductsCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func configureCell(brandProduct:ProductsResult) {
        productName.text = brandProduct.title
        
        for price in brandProduct.variants ?? [] {
            productPrice.text = price.price
            print(price.id)
        }
        print(brandProduct.variants?.first?.id)
        
        if let url = URL(string: brandProduct.image?.src ?? "") {
            let placeholder = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            self.productImage.kf.indicatorType = .activity
            self.productImage.kf.setImage(with: url,placeholder: placeholder,options: options)
        }
    }


}
