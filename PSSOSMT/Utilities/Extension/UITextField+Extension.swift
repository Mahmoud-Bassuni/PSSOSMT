//
//  UITextField.swift
//  PSSOSMT
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//
import Foundation
import UIKit
extension UITextField{
    func Placeholder(text : String!) {
        self.attributedPlaceholder = NSAttributedString(string: text,attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    func addIcon(imageName : String) {
        let image = UIImage(named: imageName);
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        imageView.backgroundColor = UIColor.white
        imageView.image = image;

        self.rightView = imageView;
        self.rightViewMode = UITextField.ViewMode.always
        //  self.leftViewMode = .always



        //        let imageView = UIImageView();
        //        let image = UIImage(named: imageName);
        //        imageView.image = image;
        //        self.rightView = imageView;
        //        self.rightViewMode = .always
    }

    func underlined(xPosition : CGFloat = 0){
        let border = CALayer()
        let width = CGFloat(1.0)
        let projectColor  = UIColor(named: "UnderLine")?.cgColor
        border.borderColor =  projectColor;
        border.frame = CGRect(x: xPosition, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

