//
//  ImageSliderCollectionViewCell.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 01.07.22.
//

import UIKit


class ImageSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
//    let producDetail : ProductDetail()
    var image: UIImage! {
        didSet{
            imageView.image = image
        }
    }
    
}
