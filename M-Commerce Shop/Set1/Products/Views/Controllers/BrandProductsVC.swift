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
    var appliedFilterArray    : [ProductsResult]!
    var isFiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceSlider.isHidden = true
        guard let title = brandName else {return}
        brandNameLabel.text = title
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BrandProductsCell", bundle: nil), forCellWithReuseIdentifier: "BrandProductsCell")
        DismissSlider()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appliedFilterArray = brandProductsArray
        Helper.hudProgress()
        listBrands()
    }
    
    func DismissSlider() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.priceSlider.isHidden = true
    }
    
    func listBrands() {
        viewModelInstance = BrandProductsViewModel()
        self.viewModelInstance?.listBrands(brandId: brandId ?? 0)
        viewModelInstance?.bindBrandProductsToProductsView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissHud()
                guard let products = self?.viewModelInstance?.brandProductsArray else{return}
                self?.brandProductsArray = products
                //self?.brandProductsArray = self?.viewModelInstance?.brandProductsArray ?? []
                self?.appliedFilterArray = self?.brandProductsArray ?? []
                //self?.filteredSportsArr = (self?.sportsArray)!
                self?.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.priceSlider.isHidden = false
        }
       
    }
    
    @IBAction func sliderDidChanged(_ sender: UISlider)  {
    
        let price = String(format: "%0.f",sender.value)
        priceLabel.text = price
        
        let filteredByPrice = self.brandProductsArray.filter { product in
            return Float(product.variants?[0].price ?? "") ?? 0 <= sender.value 
        }
        
        self.appliedFilterArray = filteredByPrice
        self.collectionView.reloadData()
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
extension BrandProductsVC :UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appliedFilterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandProductsCell", for: indexPath) as? BrandProductsCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(brandProduct: appliedFilterArray[indexPath.item])
        return cell
       
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: 300.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let data = appliedFilterArray[indexPath.item]
//
//        for price in data.variants ?? [] {
////            productPrice.text = price.price
//            print(price.id)
//        }
//        print(brandProduct.variants?.first?.id)
        
        let product = brandProductsArray[indexPath.item]
                
        guard let productDetailsVC = UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else {return}
        
        productDetailsVC.productID = product.id
        
        presentVC(vc: productDetailsVC, animated: true)
        
        
    }
    
    
}

