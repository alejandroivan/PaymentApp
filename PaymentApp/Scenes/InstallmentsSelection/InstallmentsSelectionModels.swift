//
//  InstallmentsSelectionModels.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 08-01-19.
//  Copyright (c) 2019 Alejandro Melo Domínguez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum InstallmentsSelection {
    // MARK: Use cases
    enum LoadInstallments {
        struct Request {}

        struct Response {
            let isLoading: Bool
            let payerCosts: PayerCosts
        }

        struct ErrorResponse {
            let title: String
            let message: String
        }

        struct ViewModel {
            let isLoading: Bool
            let payerCosts: [InstallmentViewModel]
        }

        struct ErrorViewModel {
            let title: String
            let message: String
            let cancelButtonTitle: String
        }
    }
}

struct InstallmentViewModel {
    let message: String
}
