//
//  ProductDetailsViewController.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 01.07.22.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let images = [
        UIImage(named: "engatiaStadium"),
        UIImage(named: "soccer-ball")
    ]
    
    var currentIndex = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = images.count
        startTimer()
        
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        let desiredScrollPosition = (currentIndex < images.count - 1) ? currentIndex + 1 : 0
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
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as! ImageSliderCollectionViewCell
        
        cell.image = images[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / imageCollectionView.frame.size.width)
        
        pageControl.currentPage = currentIndex
        
    }

}
