//
//  ConfigurationApi.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/4/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation

// MARK: - Api Keys
extension Configuration.ApiKeys {
    static var publicKey: String { return stringForSubkey("PublicKey") }
}


// MARK: - Api URLs
extension Configuration.ApiUrls {
    static var baseUrl: String {
        let base = stringForSubkey("BaseUrl")
        let version = stringForSubkey("Version")

        return base + version
    }

    static var paymentMethods: String {
        let urlString = baseUrl + stringForSubkey("PaymentMethods")
        let parameters: [String: String] = [:]

        // urlByAddingParameters() adds the public key to the query items
        // If we don't need to add additional parameters, just call it with an empty dictionary
        let url = URL(string: urlString)!.urlByAddingParameters(parameters)
        return url.absoluteString
    }

    static func cardIssuers(paymentMethodId: String) -> String {
        let urlString = baseUrl + stringForSubkey("CardIssuers")
        let parameters: [String: String] = [
            "payment_method_id" : paymentMethodId
        ]

        // urlByAddingParameters() adds the public key to the query items
        // If we don't need to add additional parameters, just call it with an empty dictionary
        let url = URL(string: urlString)!.urlByAddingParameters(parameters)
        return url.absoluteString
    }

    static func installments(paymentMethodId: String, amount: String, issuerId: String) -> String {
        let urlString = baseUrl + stringForSubkey("Installments")
        let parameters: [String: String] = [
            "payment_method_id" : paymentMethodId,
            "amount": amount,
            "issuer.id" : issuerId
        ]

        let url = URL(string: urlString)!.urlByAddingParameters(parameters)
        return url.absoluteString
    }
}
