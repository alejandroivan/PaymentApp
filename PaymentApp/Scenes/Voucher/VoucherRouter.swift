//
//  VoucherRouter.swift
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

@objc protocol VoucherRoutingLogic {
    func dismissModalScene()
}

protocol VoucherDataPassing {
    var dataStore: VoucherDataStore? { get }
}

class VoucherRouter: NSObject, VoucherRoutingLogic, VoucherDataPassing {
    weak var viewController: VoucherViewController?
    var dataStore: VoucherDataStore?

    // MARK: Routing
    func dismissModalScene() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
