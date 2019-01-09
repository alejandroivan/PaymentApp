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

    func getBanks(paymentMethodId: String,
                  success: @escaping (_ result: Banks) -> Void,
                  failure: @escaping (_ error: Error?) -> Void)

    func getInstallments(amount: Int,
                         paymentMethodId: String,
                         issuerId: String,
                         success: @escaping (_ result: Installments) -> Void,
                         failure: @escaping (_ error: Error?) -> Void)
}


// MARK: - Implementations
public class API: APIMethods {
    private static let errorDomain = "cl.penquistas.PaymentApp"

    // MARK: - Payment Methods

    func getPaymentMethods(success: @escaping (_ result: PaymentMethods) -> Void,
                           failure: @escaping (_ error: Error?) -> Void) {
        getPaymentMethods(success: success,
                          failure: failure,
                          clearCacheBeforeRequesting: true)
    }

    func getPaymentMethods(success: @escaping (_ result: PaymentMethods) -> Void,
                           failure: @escaping (_ error: Error?) -> Void,
                           clearCacheBeforeRequesting: Bool = false) {
        guard let reachable = NetworkReachabilityManager()?.isReachable, reachable else {
            let error = NSError(domain: type(of: self).errorDomain,
                                code: NSURLErrorNotConnectedToInternet,
                                userInfo: nil)
            failure(error)
            return
        }

        // Which URL to get
        let url = Configuration.ApiUrls.paymentMethods

        // Clear cache if asked to
        if clearCacheBeforeRequesting {
            URLCache.shared.removeAllCachedResponses()
        }

        // Get the data from the URL
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

    // MARK: - Banks

    func getBanks(paymentMethodId: String,
                  success: @escaping (_ result: Banks) -> Void,
                  failure: @escaping (_ error: Error?) -> Void) {
        getBanks(paymentMethodId: paymentMethodId,
                 success: success,
                 failure: failure,
                 clearCacheBeforeRequesting: true)
    }

    func getBanks(paymentMethodId: String,
                  success: @escaping (_ result: [Bank]) -> Void,
                  failure: @escaping (_ error: Error?) -> Void,
                  clearCacheBeforeRequesting: Bool = false) {
        guard let reachable = NetworkReachabilityManager()?.isReachable, reachable else {
            let error = NSError(domain: type(of: self).errorDomain,
                                code: NSURLErrorNotConnectedToInternet,
                                userInfo: nil)
            failure(error)
            return
        }

        // Which URL to get
        let url = Configuration.ApiUrls.cardIssuers(paymentMethodId: paymentMethodId)

        // Clear cache if asked to
        if clearCacheBeforeRequesting {
            URLCache.shared.removeAllCachedResponses()
        }

        // Get the data from the URL
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
                let objects = try JSONDecoder().decode(Banks.self, from: data)
                success(objects)
            } catch {
                print("Unable to decode the JSON into PaymentMethod")
                failure(nil)
            }
        }
    }

    // MARK: - Installments

    func getInstallments(amount: Int,
                         paymentMethodId: String,
                         issuerId: String,
                         success: @escaping (_ result: Installments) -> Void,
                         failure: @escaping (_ error: Error?) -> Void) {
        getInstallments(amount: amount,
                        paymentMethodId: paymentMethodId,
                        issuerId: issuerId,
                        success: success,
                        failure: failure,
                        clearCacheBeforeRequesting: true)
    }

    func getInstallments(amount: Int,
                         paymentMethodId: String,
                         issuerId: String,
                         success: @escaping (_ result: Installments) -> Void,
                         failure: @escaping (_ error: Error?) -> Void,
                         clearCacheBeforeRequesting: Bool = false) {
        guard let reachable = NetworkReachabilityManager()?.isReachable, reachable else {
            let error = NSError(domain: type(of: self).errorDomain,
                                code: NSURLErrorNotConnectedToInternet,
                                userInfo: nil)
            failure(error)
            return
        }

        // Which URL to get
        let url = Configuration.ApiUrls.installments(paymentMethodId: paymentMethodId,
                                                     amount: String(amount),
                                                     issuerId: issuerId)

        // Clear cache if asked to
        if clearCacheBeforeRequesting {
            URLCache.shared.removeAllCachedResponses()
        }

        // Get the data from the URL
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
                let objects = try JSONDecoder().decode(Installments.self, from: data)
                success(objects)
            } catch {
                print("Unable to decode the JSON into PaymentMethod")
                failure(nil)
            }
        }
    }
}
