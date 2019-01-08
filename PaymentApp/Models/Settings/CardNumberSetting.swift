//
//  CardNumberSetting.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 07-01-19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation

public struct CardNumberSetting: Decodable {
    let validation: String
    let length: Int
}
