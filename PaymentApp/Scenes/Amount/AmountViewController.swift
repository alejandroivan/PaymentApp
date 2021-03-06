//
//  AmountViewController.swift
//  PaymentApp
//
//  Created by Alejandro Melo Domínguez on 07-01-19.
//  Copyright (c) 2019 Alejandro Melo Domínguez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AmountDisplayLogic: class {
    func displayFormattedAmount(viewModel: Amount.FormatAmount.ViewModel)
    func displayClearedAmount()
}

class AmountViewController: UIViewController, AmountDisplayLogic {
    var interactor: AmountBusinessLogic?
    var router: (NSObjectProtocol & AmountRoutingLogic & AmountDataPassing)?

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nextStepButton: UIButton!

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
        let interactor = AmountInteractor()
        let presenter = AmountPresenter()
        let router = AmountRouter()
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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        amountTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        amountTextField.resignFirstResponder()
    }

    // MARK: Use cases

    func displayFormattedAmount(viewModel: Amount.FormatAmount.ViewModel) {
        amountTextField.text = viewModel.formattedAmount
        nextStepButton.isEnabled = true
    }

    func displayClearedAmount() {
        amountTextField.text = ""
        nextStepButton.isEnabled = false
    }
}

// MARK: - UITextField delegate
extension AmountViewController: UITextFieldDelegate {
    func formatAmount(amountString: String) {
        let request = Amount.FormatAmount.Request(input: amountString)
        interactor?.formatAmount(request: request)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let originalString = textField.text ?? ""
        let swiftRange = Range(range, in: originalString)!

        let finalString = originalString.replacingCharacters(in: swiftRange,
                                                             with: string)

        formatAmount(amountString: finalString)
        return false
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        formatAmount(amountString: "") // We'll delegate the clearing to the VIP cicle
        return false
    }
}
