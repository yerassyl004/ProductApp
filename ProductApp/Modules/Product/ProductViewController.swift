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
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(ProductCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getProductData()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        ProductConfigurator.shared.configure(viewController: self)
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

extension ProductViewController: ProductDisplayLogic {
    func displayProductData(viewModel: [Product.ViewModel]) {
        productData = viewModel
        collectionView.reloadData()
    }
}
