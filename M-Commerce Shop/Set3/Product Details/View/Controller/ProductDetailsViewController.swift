//
//  ProductDetailsViewController.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 01.07.22.
//

import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var favBtn: CircleButtonShadowView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
 
    
    var currentIndex = 0
    var timer: Timer?
    
    var productDetailsViewModel : ProductDetailsViewModel?
    var network : NetworkManager?
    var productDetail : ProductDetail?
    
    var selectedItem: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

            
        startTimer()

        network = NetworkManager.shared
        guard let network = network else {
            return
        }
        productDetailsViewModel = ProductDetailsViewModel(networkservice: network)
        productDetailsViewModel?.getProduct(productID: 7358110630059, completion: { productDetail in
            self.productDetail = productDetail
            print(self.productDetail)
            self.pageControl.numberOfPages = productDetail.product.images?.count ?? 1

            self.productTitle.text = productDetail.product.title

            self.productPrice.text = productDetail.product.variants?[Int()].price
            self.productDescription.text = productDetail.product.body_html
            self.imageCollectionView.reloadData()
           
        })
        
        
    }
    
    @IBAction func backBtn(_ sender: CircleButtonShadowView) {
    }
    
    @IBAction func cartBtn(_ sender: CircleButtonShadowView) {
    }
    
    @IBAction func favActionBtn(_ sender: CircleButtonShadowView) {
    }
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        let desiredScrollPosition = (currentIndex < (productDetail?.product.images?.count ?? 1) - 1) ? currentIndex + 1 : 0
        imageCollectionView.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productDetail?.product.images?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as! ImageSliderCollectionViewCell
        let url = URL(string: productDetail?.product.images?[indexPath.row].src ?? "")
        //(self.bounds.size)
//        let size =   CGSize(width: 200, height: 80)
        let processor = DownsamplingImageProcessor(size:
                                                    self.imageCollectionView.frame.size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "football"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
//        cell.image = pro[indexPath.item]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / imageCollectionView.frame.size.width)
        
        pageControl.currentPage = currentIndex
        
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedItem = indexPath.row
        
        return true
    }

}
