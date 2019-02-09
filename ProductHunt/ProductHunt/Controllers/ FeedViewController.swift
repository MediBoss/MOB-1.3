//
//   FeedViewController.swift
//  ProductHunt
//
//  Created by Medi Assumani on 1/25/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//
import Foundation
import UIKit

class FeedViewController: UIViewController{
    
    
    var products = [Product](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        view.addSubview(collectionView)
        anchorFeedCollectionView()
        fecthProducts()
    }
    
    
    private func anchorFeedCollectionView(){

        collectionView.anchor(top: view.topAnchor,
                               left: view.leftAnchor,
                               bottom: view.bottomAnchor,
                               right: view.rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 0,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 0,
                               height: 0,
                               enableInsets: false)
    }
    
    private func fecthProducts(){
        
        NetworkManager.getProducts { (productsFromAPI) in
            self.products = productsFromAPI
        }
    }
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .lightGray
        collectionView.register(FeedViewCell.self, forCellWithReuseIdentifier: FeedViewCell.identifier)
        
        return collectionView
    }()
}


extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedViewCell.identifier, for: indexPath) as! FeedViewCell
        
        var currentProduct = products[indexPath.row]
        cell.productNameLabel.text = currentProduct.name
        cell.productCommentsLabel.text = currentProduct.commentsCount.toString()
        cell.productTagLineLabel.text = currentProduct.tagline
        cell.productVotesCountLabel.text = currentProduct.votesCount.toString()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        let destinationVC = CommentsView()
        //destinationVC.comments = selectedProduct.
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = collectionView.bounds.width
        return CGSize(width: screenWidth/1.2, height: screenWidth/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
