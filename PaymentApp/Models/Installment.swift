//
//  Installment.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/9/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

public typealias Installments = [Installment]

public struct Installment: Decodable {
    let paymentMethodId: String
    let paymentTypeId: String
    let issuer: Issuer
    let processingMode: ProcessingMode
    var merchantAccountId: String?
    let payerCosts: PayerCosts
}

// MARK: - Coding Keys
extension Installment {
    enum CodingKeys: String, CodingKey {
        case issuer
        case paymentMethodId = "payment_method_id"
        case paymentTypeId = "payment_type_id"
        case processingMode = "processing_mode"
        case merchantAccountId = "merchant_account_id"
        case payerCosts = "payer_costs"
    }
}
