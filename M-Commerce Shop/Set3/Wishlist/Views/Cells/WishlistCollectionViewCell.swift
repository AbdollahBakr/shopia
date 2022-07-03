//
//  WishlistCollectionViewCell.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 29.06.22.
//

import UIKit

class WishlistCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageProduct: RoundedImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    var wishlistViewModel : WishlistViewModel?
    var productID: String?
    var wishlistVC: WishlistViewController?
    var indexPath: Int?
    
    static let identifier = "WishlistCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setData(wishlistViewModel : WishlistViewModel, productID: String, wishlistVC: WishlistViewController, indexPath: Int){
        self.wishlistViewModel = wishlistViewModel
        self.productID = productID
        self.wishlistVC = wishlistVC
        self.indexPath = indexPath
    }
    
    
    @IBAction func favBtnAction(_ sender: CircleButtonShadowView) {
        wishlistViewModel?.localDataSource.delete(productID: productID ?? "")
        wishlistVC?.updateWishlistViewCells(indexpath: self.indexPath ?? 0)
        
            
    }

}
