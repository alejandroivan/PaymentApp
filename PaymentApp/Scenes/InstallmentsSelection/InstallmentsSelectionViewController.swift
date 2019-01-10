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
    func showLoadingIndicator()
    func hideLoadingIndicator()

    func displayInstallments(viewModel: InstallmentsSelection.LoadInstallments.ViewModel)
    func displayErrorMessage(viewModel: InstallmentsSelection.LoadInstallments.ErrorViewModel)
}

class InstallmentsSelectionViewController: UIViewController, InstallmentsSelectionDisplayLogic {
    var interactor: InstallmentsSelectionBusinessLogic?
    var router: (NSObjectProtocol & InstallmentsSelectionRoutingLogic & InstallmentsSelectionDataPassing)?

    private var installments: [InstallmentViewModel] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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
        loadInstallments()
    }

    // MARK: Do something
    func showLoadingIndicator() {
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }

    func displayInstallments(viewModel: InstallmentsSelection.LoadInstallments.ViewModel) {
        installments = viewModel.payerCosts
        tableView.reloadData()

        if viewModel.isLoading {
            showLoadingIndicator()
        } else {
            hideLoadingIndicator()
        }
    }

    func displayErrorMessage(viewModel: InstallmentsSelection.LoadInstallments.ErrorViewModel) {
        installments = []
        tableView.reloadData()

        let alertController = UIAlertController(title: viewModel.title,
                                                message: viewModel.message,
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: viewModel.cancelButtonTitle,
                                                style: .cancel,
                                                handler: { _ in
                                                    self.navigationController?.popViewController(animated: true)
        }))

        hideLoadingIndicator()
        present(alertController, animated: true, completion: nil)
    }

    // MARK: Methods
    func loadInstallments() {
        let request = InstallmentsSelection.LoadInstallments.Request()
        interactor?.loadInstallments(request: request)
    }

    func goBackToAmount() {
        if let vc = navigationController?.viewControllers.first as? AmountDisplayLogic {
            vc.displayClearedAmount()
        }

        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UITableView DataSource & Delegate
extension InstallmentsSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    private static let cellIdentifier = "InstallmentsSelectionTableViewCell"

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).cellIdentifier
        let installment = installments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        cell.textLabel?.text = installment.message

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let recommendedMessage = installments[selectedIndex].message

        let fullMessage = "Se realizará tu compra con el siguiente detalle:\n\n\(recommendedMessage)"

        let alertController = UIAlertController(title: "Confirmar compra",
                                                message: fullMessage,
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Comprar",
                                                style: .default,
                                                handler: { (_) in
                                                    self.tableView.deselectRow(at: indexPath, animated: true)

                                                    self.interactor?.didConfirmPayerCost(at: selectedIndex,
                                                                                         completion: {
                                                                                            self.performSegue(withIdentifier: "Voucher", sender: nil)
                                                                                            self.goBackToAmount()
                                                    })
        }))

        alertController.addAction(UIAlertAction(title: "Cancelar",
                                                style: .cancel,
                                                handler: { (_) in
                                                    self.tableView.deselectRow(at: indexPath, animated: true)
        }))

        present(alertController, animated: true, completion: nil)
    }
}
