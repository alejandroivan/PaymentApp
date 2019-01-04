//
//  API.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/4/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation

// MARK: - Protocol
protocol APIMethods {
    func getPaymentMethods(success: @escaping (_ result: [PaymentMethod]) -> Void,
                           failure: @escaping (_ error: Any) -> Void)
}


// MARK: - Implementations
public class API: APIMethods {
    func getPaymentMethods(success: @escaping (_ result: [PaymentMethod]) -> Void,
                           failure: @escaping (_ error: Any) -> Void) {
        
    }
}
