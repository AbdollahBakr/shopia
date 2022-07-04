//
//  BrandProductsVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 03/07/2022.
//

import UIKit

class BrandProductsVC: UIViewController {
    
    @IBOutlet weak var brandNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceSlider: UISlider!
    
    @IBOutlet weak var priceLabel: UILabel!
    /********************Variables***************/
    var viewModelInstance     : BrandProductsViewModel?
    var brandName             : String?
    var brandId               : Int?
    var brandProductsArray    = [ProductsResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceSlider.isHidden = true
        guard let title = brandName else {return}
        brandNameLabel.text = title
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BrandProductsCell", bundle: nil), forCellWithReuseIdentifier: "BrandProductsCell")
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Helper.hudProgress()
        listBrands()
    }
    
    func listBrands() {
        viewModelInstance = BrandProductsViewModel()
        self.viewModelInstance?.listBrands(brandId: brandId ?? 0)
        viewModelInstance?.bindBrandProductsToProductsView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissHud()
                self?.brandProductsArray = self?.viewModelInstance?.brandProductsArray ?? []
                //self?.filteredSportsArr = (self?.sportsArray)!
                self?.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.priceSlider.isHidden = false
        }
       
    }
    
    @IBAction func sliderDidChanged(_ sender: Any) {
        //brandProductsArray.filter({$0.variants?.contains(where: $0.)})
        let value = priceSlider.value
        priceLabel.text = "\(value)"
       // brandProductsArray = brandProductsArray.filter({$0.variants?.filter({$0.price == [Int(sender.value)] })})
        
//        brandProductsArray.filter({$0.variants?.filter({(Float($0.price ?? "")) == value})})
//        for price in brandProductsArray {
//            for specificPrice in price.variants ?? [] {
//                let price = "\(specificPrice.price)"
//                specificPrice.price.sta
            
//             price.variants?.filter({(Float($0.price ?? "")) == value})
//            }
//        }
        
    }
}
extension BrandProductsVC :UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandProductsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandProductsCell", for: indexPath) as? BrandProductsCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(brandProduct: brandProductsArray[indexPath.item])
        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: 300.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

