//
//  BaseViewModel.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import Foundation
struct BrokenRule {

    var proprityName : String
    var message : String

}

protocol BaseViewModel {
    var brokenRules : [String] { get set }
    var isValid : Bool { get }
}
