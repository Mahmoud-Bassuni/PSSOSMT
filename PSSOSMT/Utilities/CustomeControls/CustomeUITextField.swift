//
//  sssss.swift
//  PSSOSMT
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//
import Foundation
import UIKit
class CustomeUITextField : UITextField
{

    @IBInspectable  public var enableDesign: Bool = true


    override func awakeFromNib() {
        super.awakeFromNib()
        if enableDesign
        {
            self.layer.cornerRadius = 8
            self.backgroundColor = UIColor.clear
            self.borderStyle = .roundedRect
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor(named: "MenuColor")?.cgColor
        }

    }
}
