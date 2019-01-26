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
    
    var feedCollectView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        configureFeedCollectionView()
        feedCollectView.dataSource = self as UICollectionViewDataSource
        feedCollectView.delegate = self as UICollectionViewDelegate
        //anchorFeedCollectionView()
    }
    
    private func configureFeedCollectionView(){
        
        feedCollectView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        feedCollectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        feedCollectView.backgroundColor = .red
        feedCollectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    private func anchorFeedCollectionView(){
        
        feedCollectView.anchor(top: view.topAnchor,
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
}


extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
    
        return cell
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
