//
//  InstallmentsSelectionRouter.swift
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

@objc protocol InstallmentsSelectionRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeToVoucher(segue: UIStoryboardSegue?)
}

protocol InstallmentsSelectionDataPassing {
    var dataStore: InstallmentsSelectionDataStore? { get }
}

class InstallmentsSelectionRouter: NSObject, InstallmentsSelectionRoutingLogic, InstallmentsSelectionDataPassing {
    weak var viewController: InstallmentsSelectionViewController?
    var dataStore: InstallmentsSelectionDataStore?

    // MARK: Routing

    func routeToVoucher(segue: UIStoryboardSegue?)
    {
      if let segue = segue {
        let destinationVC = segue.destination as! VoucherViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToVoucher(source: dataStore!, destination: &destinationDS)
      } else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateInitialViewController() as! VoucherViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToVoucher(source: dataStore!, destination: &destinationDS)
        navigateToVoucher(source: viewController!, destination: destinationVC)
      }
    }

    // MARK: Navigation

    func navigateToVoucher(source: InstallmentsSelectionViewController, destination: VoucherViewController)
    {
      source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToVoucher(source: InstallmentsSelectionDataStore, destination: inout VoucherDataStore) {
        destination.amount = source.amount
        destination.paymentMethod = source.paymentMethod
        destination.cardIssuer = source.cardIssuer
        destination.installment = source.selectedPayerCost
    }
}
