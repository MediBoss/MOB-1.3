//
//  CommentsTableViewCell.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/8/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    open var commentBody = UITextView()
    static let id = "commentCell"
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpTextView(){
        
        commentBody.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        addSubview(commentBody)
    }

}
