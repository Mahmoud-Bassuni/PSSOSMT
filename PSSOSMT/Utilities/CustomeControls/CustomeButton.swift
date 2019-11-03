//
//  ss.swift
//  PSSOSMT
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//
import Foundation
import UIKit
class CustomeButton : UIButton
{

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true

        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize.zero // Use any CGSize
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
    }
}
class CustomeButtonWithLightRadius : UIButton
{

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = self.layer.backgroundColor
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.layer.shadowOffset = CGSize.zero // Use any CGSize
        self.layer.borderWidth = 1.0
    }
}
