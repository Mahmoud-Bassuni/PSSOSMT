//
//  CustomeUIView.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//


import Foundation
import UIKit
class CustomeUIView : UIView
{




    override func awakeFromNib() {
        super.awakeFromNib()
         self.layer.borderWidth = 0.25
                      self.layer.borderColor = UIColor.white.cgColor
                      //To apply Shadow
                      self.layer.shadowOpacity = 1
                      self.layer.shadowRadius = 3.0
                      self.layer.shadowOffset = CGSize.zero // Use any CGSize
                      self.layer.shadowColor = UIColor.lightGray.cgColor
                      self.layer.cornerRadius = 8
    }
}
