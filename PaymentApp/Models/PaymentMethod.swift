//
//  PaymentMethod.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/4/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

public typealias PaymentMethods = [PaymentMethod]

public struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let paymentTypeId: PaymentType
    let status: String
    let secureThumbnail: String
    let thumbnail: String
    let deferredCapture: String
    let settings: [Setting]
    let additionalInfoNeeded: [AdditionalInfo]
    let minAllowedAmount: Double
    let maxAllowedAmount: Double
    let accreditationTime: Int
    let financialInstitutions: [FinancialInstitution] // Not needed for this example
    let processingModes: [ProcessingMode]
}

// MARK: - Coding Keys
extension PaymentMethod {
    enum CodingKeys: String, CodingKey {
        case id, name, status, thumbnail, settings
        case paymentTypeId = "payment_type_id"
        case secureThumbnail = "secure_thumbnail"
        case deferredCapture = "deferred_capture"
        case additionalInfoNeeded = "additional_info_needed"
        case minAllowedAmount = "min_allowed_amount"
        case maxAllowedAmount = "max_allowed_amount"
        case accreditationTime = "accreditation_time"
        case financialInstitutions = "financial_institutions"
        case processingModes = "processing_modes"
    }
}

// MARK: - Filtering credit cards
extension Sequence where Iterator.Element == PaymentMethod {
    var creditCards: [PaymentMethod] {
        return self.filter { $0.paymentTypeId == .creditCard }
    }
}
