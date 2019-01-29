//
//  FeedViewCell.swift
//  ProductHunt
//
//  Created by Medi Assumani on 1/29/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class FeedViewCell: UICollectionViewCell{
    
    static var identifier: String = "feedviewcollectionCell"
    open var productNameLabel = CustomLabel(fontSize: 10, text: "", textColor: .black, textAlignment: .right, fontName: "Helvetica-Light")
    open var productTagLineLabel = CustomLabel(fontSize: 10, text: "", textColor: .black, textAlignment: .center, fontName: "Helvetica-Light")
    open var productCommentsLabel = CustomLabel(fontSize: 10, text: "", textColor: .black, textAlignment: .center, fontName: "Helvetica-Ligth")
    open var productVotesCountLabel = CustomLabel(fontSize: 10, text: "", textColor: .black, textAlignment: .center, fontName: "Helvetica-Light")
    open var productThunmbnail = UIImageView(image: UIImage(named: "ph"))
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
        self.backgroundView = productThunmbnail
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCellLayout(){
        
        
    }
    
}
