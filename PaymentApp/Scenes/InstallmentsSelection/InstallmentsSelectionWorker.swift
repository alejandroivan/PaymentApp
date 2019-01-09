//
//  InstallmentsSelectionWorker.swift
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

class InstallmentsSelectionWorker {
    func getInstallments(amount: Int,
                         paymentMethodId: String,
                         issuerId: String,
                         completion: @escaping ((Installments?, Bool, Error?) -> Void)) {
        API().getInstallments(amount: amount,
                              paymentMethodId: paymentMethodId,
                              issuerId: issuerId,
                              success: { (installment) in
                                completion(installment, true, nil)
        }) { (error) in
            completion(nil, false, error)
        }
    }
}
