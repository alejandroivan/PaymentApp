//
//  VoucherPresenter.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 1/10/19.
//  Copyright (c) 2019 Alejandro Melo Domínguez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol VoucherPresentationLogic {
    func displayData(response: Voucher.ShowData.Response)
    func dismissVoucher()
}

class VoucherPresenter: VoucherPresentationLogic {
    weak var viewController: VoucherDisplayLogic?

    // MARK: Presentation Logic

    func displayData(response: Voucher.ShowData.Response) {
        guard let amount = response.amount, let paymentMethod = response.paymentMethodName, let bank = response.bank, let installments = response.installments else {
                return // Should never happen if we're here, but just in case...
        }

        let viewModel = Voucher.ShowData.ViewModel(amount: "$\(amount)",
                                                   paymentMethodName: paymentMethod,
                                                   bank: bank,
                                                   installments: installments)

        viewController?.displayData(viewModel: viewModel)
    }

    func dismissVoucher() {
        viewController?.dismissPopup()
    }
}
