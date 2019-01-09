//
//  Issuer.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/9/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

public class Issuer: Decodable {
    let id: String
    let name: String
    let secureThumbnail: String
    let thumbnail: String
}

extension Issuer {
    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail
        case secureThumbnail = "secure_thumbnail"
    }
}
