//
//  PaymentType.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 07-01-19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

public enum PaymentType: String, Decodable {
    case ticket = "ticket"
    case debitCard = "debit_card"
    case creditCard = "credit_card"
}
