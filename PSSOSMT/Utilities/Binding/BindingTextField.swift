//
//  xx.swift
//  PSSOSMT
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//


import Foundation
import UIKit
class BindingTextField : CustomeUITextField{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var textChange : (String) -> ()    = { _ in }
    func bind (callBack :@escaping (String) -> ()){
        self.textChange = callBack
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    @objc func textFieldDidChange (_ textfield :UITextField){
        self.textChange(textfield.text!);
    }
}
