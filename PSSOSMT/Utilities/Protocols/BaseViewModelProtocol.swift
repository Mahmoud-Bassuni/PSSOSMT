//
//  BaseViewModelProtocol.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import Foundation
import Foundation
protocol BaseViewModelProtocol
{
    func showLoading()
    func hideLoading()
    func callback()
    func showAlert(message : String)
}
