//
//  TeamsCell.swift
//  SportsApp
//
//  Created by Macbook on 13/06/2022.
//

import UIKit
import Kingfisher

class BrandsCell: UICollectionViewCell {
    
    
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var brandImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
  
      
    func configureCell(brands: SmartCollections?) {
        
        self.brandLabel.text = brands?.title
    
        DispatchQueue.main.async {
            if let url = URL(string: brands?.image?.src ?? "") {
                //let placeholder = UIImage(named: "placeholder")
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
                self.brandImageView.kf.indicatorType = .activity
                self.brandImageView.kf.setImage(with: url,placeholder: nil,options: options)
            }
        }
    }
}
