//
//  CustomViews.swift
//  ProductHunt
//
//  Created by Medi Assumani on 1/29/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(fontSize: CGFloat, text: String, textColor: UIColor, textAlignment: NSTextAlignment, fontName: String) {
        
        self.init()
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont(name: fontName, size: fontSize)
        self.translatesAutoresizingMaskIntoConstraints = false

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class CustomStackView: UIStackView{
        
        override init(frame: CGRect) {
            
            super.init(frame: frame)
        }
        
        required init(coder: NSCoder) {
            
            fatalError("init(coder:) has not been implemented")
        }
        convenience init (subviews: [UIView], alignment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution){
            
            self.init(arrangedSubviews: subviews)
            self.alignment = alignment
            self.axis = axis
            self.distribution = distribution
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    class CustomButton: UIButton{
        
        override init(frame: CGRect) {
            
            super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            fatalError("init(coder:) has not been implemented")
        }
        convenience init(title: String, fontSize: CGFloat, titleColor: UIColor,target: Any?, action: Selector, event: UIControl.Event, titleFontName: String){
            
            self.init()
            
            self.setTitle(title, for: .normal)
            self.setTitleColor(titleColor, for: .normal)
            self.addTarget(target, action: action, for: event)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.isEnabled = true
            self.titleLabel!.font = UIFont(name: titleFontName, size: fontSize)
        }
    }
}
