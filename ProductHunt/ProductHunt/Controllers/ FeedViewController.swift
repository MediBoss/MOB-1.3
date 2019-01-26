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
    
    lazy var feedCollectView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFeedCollectionView()
    }
    
    private func configureFeedCollectionView(){
        
        feedCollectView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        feedCollectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        feedCollectView.dataSource = self
        feedCollectView.delegate = self
        feedCollectView.backgroundColor = .red
        feedCollectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    private func anchorFeedCollectionView(){
        
    }
}


extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell.self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell at \(indexPath.row) selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout{
    
}
