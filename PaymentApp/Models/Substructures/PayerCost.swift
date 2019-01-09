//
//  PayerCost.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/9/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

public typealias PayerCosts = [PayerCost]

public struct PayerCost: Decodable {
    let installments: Int
    let installmentRate: Double
    let discountRate: Double
    let labels: [String]
    let installmentRateCollector: [String]
    let minAllowedAmount: Int
    let maxAllowedAmount: Int
    let recommendedMessage: String
    let installmentAmount: Double
    let totalAmount: Double
}

// MARK: - Coding Keus
extension PayerCost {
    enum CodingKeys: String, CodingKey {
        case installments, labels
        case installmentRate = "installment_rate"
        case discountRate = "discount_rate"
        case installmentRateCollector = "installment_rate_collector"
        case minAllowedAmount = "min_allowed_amount"
        case maxAllowedAmount = "max_allowed_amount"
        case recommendedMessage = "recommended_message"
        case installmentAmount = "installment_amount"
        case totalAmount = "total_amount"
    }
}
