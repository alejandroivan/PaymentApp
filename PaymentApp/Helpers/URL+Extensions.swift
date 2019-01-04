//
//  URL+Extensions.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/4/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation

public extension URL {
    public func urlByAddingParameters(_ parameters: [String: String]) -> URL {
        // Force unwrap, since this URL is not nil if the developer gets to this point
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = components.queryItems ?? []

        // Add the public key to the query items. This will be replaced if the public_key key
        // comes in the parameters dictionary
        queryItems.append(URLQueryItem(name: "public_key", value: Configuration.ApiKeys.publicKey))

        // Processing parameters (query items)
        var newParams: [String: String] = [:]

        // Start with current query items. This will also remove duplicate query items.
        queryItems.forEach {
            newParams[$0.name] = $0.value
        }

        // Now add the new ones. If one already exists, it will be replaced.
        parameters.forEach {
            let (key, value) = $0
            newParams[key] = value
        }

        // Empty the initial query items...
        queryItems.removeAll()

        // ...and fill it with the new values.
        newParams.forEach {
            let (key, value) = $0
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        components.queryItems = queryItems
        return components.url!
    }
}
