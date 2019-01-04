//
//  Configuration.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/4/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation

public struct Configuration {
    public struct ApiKeys {
        private static let configurationKey = "ApiKeys"
        static func stringForSubkey(_ subkey: String) -> String {
            return Configuration.configurationStringFor(key: configurationKey, subkey: subkey)
        }
    }

    public struct ApiUrls {
        private static let configurationKey = "ApiUrls"
        static func stringForSubkey(_ subkey: String) -> String {
            return Configuration.configurationStringFor(key: configurationKey, subkey: subkey)
        }
    }
}

// MARK: - Api Keys
extension Configuration {

    public static var configurationDictionary: [String: Any] {
        let bundle = Bundle.main

        guard let url = bundle.url(forResource: "Configuration", withExtension: "plist") else {
            fatalError("Configuration.plist couldn't be found.")
        }

        do {
            let data = try Data(contentsOf: url)
            return try PropertyListSerialization.propertyList(from: data,
                                                              options: [],
                                                              format: nil) as! [String: Any]
        } catch {
            fatalError("The contents of Configuration.plist are invalid or not readable.")
        }
    }

    public static func configurationObjectFor(key: String, subkey: String) -> Any {
        let config = configurationDictionary
        guard let dictionary = config[key] as? [String: Any] else {
            fatalError("The specified Configuration key doesn't exist.")
        }

        guard let value = dictionary[subkey] else {
            fatalError("The specified subkey doesn't exist.")
        }

        return value
    }

    public static func configurationStringFor(key: String, subkey: String) -> String {
        guard let value = configurationObjectFor(key: key, subkey: subkey) as? String else {
            fatalError("The object corresponding to the subkey is not a string.")
        }

        return value
    }

}
