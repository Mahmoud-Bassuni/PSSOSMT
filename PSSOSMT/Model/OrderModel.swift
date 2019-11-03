//
//  OrderModel.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import Foundation
struct OrdersCodableModel: Codable {
    let value: [OrdersCodableValue]!
    let errors: [String]!

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case errors = "Errors"
    }
}

// MARK: - Value
struct OrdersCodableValue: Codable {
    let id: Int!
    let employee, orderStatus: DataModelCodable!
    let orderItems: [DataModelCodable]!
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case employee = "Employee"
        case orderStatus = "OrderStatus"
        case orderItems = "OrderItems"
    }
}

// MARK: - Employee
struct DataModelCodable: Codable {
    let id: Int!
    let nameAr: String!
    let nameEn: String!
    let imagePath: String!

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nameAr = "NameAr"
        case nameEn = "NameEn"
        case imagePath = "ImagePath"
    }
}
struct UpdateOrderStatusCodableModel: Codable {
    let value: Bool?
    let errors: [String]?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case errors = "Errors"
    }
}
