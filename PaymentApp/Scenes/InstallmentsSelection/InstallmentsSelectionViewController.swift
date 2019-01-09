//
//  InstallmentsSelectionViewController.swift
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

protocol InstallmentsSelectionDisplayLogic: class {
    func displaySomething(viewModel: InstallmentsSelection.Something.ViewModel)
}

class InstallmentsSelectionViewController: UIViewController, InstallmentsSelectionDisplayLogic {
    var interactor: InstallmentsSelectionBusinessLogic?
    var router: (NSObjectProtocol & InstallmentsSelectionRoutingLogic & InstallmentsSelectionDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = InstallmentsSelectionInteractor()
        let presenter = InstallmentsSelectionPresenter()
        let router = InstallmentsSelectionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething() {
        let request = InstallmentsSelection.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: InstallmentsSelection.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
