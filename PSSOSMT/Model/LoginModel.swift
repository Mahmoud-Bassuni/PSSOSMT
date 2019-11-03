//
//  LoginModel.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import Foundation
import Foundation

// MARK: - LoginModel
struct LoginCodableModel: Codable {
    let value: teaBoyInfoCodableModel?
    let errors: [String]?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case errors = "Errors"
    }
}

// MARK: - Value
struct teaBoyInfoCodableModel: Codable {
    let id: Int!
    let nameAr, nameEn: String!

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nameAr = "NameAr"
        case nameEn = "NameEn"
    }
}
