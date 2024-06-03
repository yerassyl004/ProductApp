//
//  ProductViewController.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 03.06.2024.
//

import UIKit
import SnapKit

protocol ProductDisplayLogic: AnyObject {
    func displayProductData(viewModel: [Product.ViewModel])
}

final class ProductViewController: UIViewController {
    
    // MARK: - Deps
    var interactor: ProductBusinessLogic?
    var router: (NSObjectProtocol & ProductRoutingLogic & ProductDataPassing)?
    var productData = [Product.ViewModel]()
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(ProductTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        ProductConfigurator.shared.configure(viewController: self)
        view.backgroundColor = .systemGray6
        interactor?.getProductData()
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ProductViewController: ProductDisplayLogic {
    func displayProductData(viewModel: [Product.ViewModel]) {
        productData = viewModel
        tableView.reloadData()
    }
}

