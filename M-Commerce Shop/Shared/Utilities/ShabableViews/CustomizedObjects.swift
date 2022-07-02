//
//  RoundedViews.swift
//  One
//
//  Created by Macbook on 11/17/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

/************************   UIButton    *****************************/
class RoundedShodowButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        self.layer.mask = shapeLayer
        
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

class RoundedView:UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = 10
        self.layer.cornerRadius = radius
    }
}

class RoundedButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        self.layer.mask = shapeLayer
        
    }
}

class CircleButtonView: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
}

class CircleButtonShadowView: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
//        layer.masksToBounds = true
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
    
}


/************************     UITextField  *****************************/
class TextFieldPadding : UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
//         layer.borderWidth = 1.0
//        layer.borderColor = UIColor(named:"MainColor")?.cgColor
    }
   
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


/************************     UIVisualEffectView  *****************************/
class RoundedVisualEffectView : UIVisualEffectView {

    override func layoutSubviews() {
        super.layoutSubviews()
        updateMaskLayer()
    }

    func updateMaskLayer(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight,.topLeft,.topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        self.layer.mask = shapeLayer
    }
}


/************************    UIViews  *****************************/
class RoundedShadowView : UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = 10
        self.layer.cornerRadius = radius
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

class RoundedSheetShape : UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
}

extension UIView {
    // Called computed (Property / Var)
    @IBInspectable var borderWidth :CGFloat {
        get {
            return 0
        }
        set(value){
            self.layer.borderWidth = value
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius :CGFloat {
        get {
            return 0
        }
        set(value){
            self.layer.cornerRadius = value
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor :UIColor? {
        
        get {
            return UIColor(cgColor: UIColor.clear.cgColor)
        }
        set(value){
            self.layer.borderColor = value?.cgColor ?? UIColor.clear.cgColor
            self.layer.masksToBounds = true
        }
        
    }
}


extension UIView {
    enum ViewSide {
        case Top, Bottom, Left, Right
    }

    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color.cgColor

        switch side {
        case .Top:
            border.frame = CGRect(x: 20, y: -8, width: frame.size.width - 40, height: thickness)
        case .Bottom:
            border.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
        case .Right:
            border.frame = CGRect(x: frame.size.width - thickness, y: 0, width: thickness, height: frame.size.height)
        }

        layer.addSublayer(border)
    }
}


/************************     UIImageView  *****************************/
class RoundedImageView : UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = 10
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class CircleImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}


    

