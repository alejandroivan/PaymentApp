//
//  SecurityCodeSetting.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 07-01-19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation

public struct SecurityCodeSetting: Decodable {
    let length: Int
    let cardLocation: SecurityCodeLocation
    let mode: SecurityCodeMode
}

// MARK: - Coding Keys
extension SecurityCodeSetting {
    enum CodingKeys: String, CodingKey {
        case length, mode
        case cardLocation = "card_location"
    }
}

// MARK: - Enumerations
public enum SecurityCodeLocation: String, Decodable {
    case back = "back"
    case front = "front"
}

public enum SecurityCodeMode: String, Decodable {
    case mandatory = "mandatory"
    case optional = "optional"
}
