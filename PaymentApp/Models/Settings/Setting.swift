//
//  Setting.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 07-01-19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation

public struct Setting: Decodable {
    let cardNumber: CardNumberSetting
    let bin: BinSetting
    let securityCode: SecurityCodeSetting
}

// MARK: - Coding Keys
extension Setting {
    enum CodingKeys: String, CodingKey {
        case bin
        case cardNumber = "card_number"
        case securityCode = "security_code"
    }
}
