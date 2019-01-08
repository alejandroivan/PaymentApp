//
//  AdditionalInfo.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 07-01-19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

public enum AdditionalInfo: String, Decodable {
    case issuerId = "issuer_id"
    case cardholderName = "cardholder_name"
    case cardholderIdentificationType = "cardholder_identification_type"
    case cardholderIdentificationNumber = "cardholder_identification_number"
}
