//
//  API.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/4/19.
//  Copyright © 2019 Alejandro Melo Domínguez. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Protocol
protocol APIMethods {
    func getPaymentMethods(success: @escaping (_ result: [PaymentMethod]) -> Void,
                           failure: @escaping (_ error: Error?) -> Void)
}


// MARK: - Implementations
public class API: APIMethods {
    func getPaymentMethods(success: @escaping (_ result: [PaymentMethod]) -> Void,
                           failure: @escaping (_ error: Error?) -> Void) {
        let url = Configuration.ApiUrls.paymentMethods

        Alamofire.request(url, method: .get, headers: nil).responseJSON { response in
            guard response.error == nil else {
                failure(response.error)
                return
            }

            guard let data = response.data else {
                print("The server returned empty data")
                failure(nil)
                return
            }

            do {
                let objects = try JSONDecoder().decode(PaymentMethods.self, from: data)
                success(objects)
            } catch {
                print("Unable to decode the JSON into PaymentMethod")
                failure(nil)
            }
        }
    }
}
