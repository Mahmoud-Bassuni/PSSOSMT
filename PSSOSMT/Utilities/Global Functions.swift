//
//  Constants.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import Foundation
import UIKit
func generateBasicAuthorization() -> String {
    let defaults:UserDefaults = UserDefaults.standard
    let userId = String(defaults.integer(forKey: "UserId"))
    let userToken = defaults.string(forKey: "UserCode")
    let loginString = String(format: "%@:%@", userId, userToken!)
    let loginData = loginString.data(using: String.Encoding.utf8)!
    return  loginData.base64EncodedString()
}
func getDeviceInfo() -> DeviceInfo
{
    let _accessToken = UserDefaults.standard.string(forKey: "Usertoken")
    let _imei = UIDevice.current.identifierForVendor!.uuidString 
    return DeviceInfo(accessToken: _accessToken, imei: _imei)

}
struct DeviceInfo
{
    var accessToken : String!
    var imei : String!
}
