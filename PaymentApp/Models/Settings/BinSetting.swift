//
//  BinSetting.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 07-01-19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation

public struct BinSetting: Decodable {
    let pattern: String
    var installmentsPattern: String?
    var exclusionPattern: String?
}

// MARK: - Coding Keys
extension BinSetting {
    enum CodingKeys: String, CodingKey {
        case pattern
        case installmentsPattern = "installments_pattern"
        case exclusionPattern = "exclusion_pattern"
    }
}
