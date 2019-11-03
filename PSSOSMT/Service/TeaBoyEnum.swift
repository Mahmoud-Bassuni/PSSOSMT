//
//  ssss.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//
import Foundation
import Moya
enum TeaBoyEnum{
    case login(userCode : String)
    case getTeaBoyOrders
    case updateTeaBoyOrderStatus(orderId : Int , statusID : Int)
}
extension TeaBoyEnum: TargetType{
    var baseURL: URL {
            return URL(string: EndPoint.baseUrl.rawValue)!
    }
    var path: String {
        switch self{
        case .login: return EndPoint.loginURL.rawValue
        case .getTeaBoyOrders: return EndPoint.getTeaBoyOrdersURL.rawValue
        case .updateTeaBoyOrderStatus: return EndPoint.tBoyChangeOrderStatusURL.rawValue
        }
    }
    var method: Moya.Method {
        switch self{
        case .login , .updateTeaBoyOrderStatus: return .post
        case .getTeaBoyOrders: return .get
        }

    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        let deviceInfo = getDeviceInfo()
        switch self {
           case let .login(userCode):
        return .requestParameters(parameters:
            ["code": userCode, "IMEI" : deviceInfo.imei ?? "" , "AccessToken" : deviceInfo.accessToken ?? ""], encoding: URLEncoding.queryString)
        case .getTeaBoyOrders : return .requestPlain
        case let .updateTeaBoyOrderStatus(orderId ,statusID):
            return .requestParameters(parameters:
            ["orderId": orderId, "statusId" : statusID], encoding: URLEncoding.queryString)
        }
    }
    var headers: [String : String]?{
        switch self {
        case .login:
            return ["Content-Type" : "application/json"]
            case .getTeaBoyOrders , .updateTeaBoyOrderStatus:
                return ["Content-Type" : "application/json" , "Authorization" : "Basic " + generateBasicAuthorization()]
        }
    }
}
