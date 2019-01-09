//
//  Bank.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 08-01-19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

public typealias Banks = [Bank]

public struct Bank: Decodable {
    let id: String
    let name: String
    let secureThumbnail: String
    let thumbnail: String
    let processingMode: ProcessingMode
    var merchantAccountId: String?
}

extension Bank {
    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail
        case secureThumbnail = "secure_thumbnail"
        case processingMode = "processing_mode"
        case merchantAccountId = "merchant_account_id"
    }
}
