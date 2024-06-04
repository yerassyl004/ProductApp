//
//  ProductTableViewCell.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 03.06.2024.
//

import UIKit
import SnapKit
import CoreData

final class ProductCollectionViewCell: UICollectionViewCell {
    
    private var productData: Product.ViewModel?
    
    // MARK: - UI
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var addToFavoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.layer.shadowOpacity = 5
        button.addTarget(self, action: #selector(addToFavoritesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var productAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.contentView.layer.cornerRadius = 16
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        productTitleLabel.text = nil
        productAmountLabel.text = nil
        addToFavoritesButton.setImage(nil, for: .normal)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .systemGray6
        [productTitleLabel, productImageView, productAmountLabel, addToFavoritesButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(contentView.bounds.width - 16)
        }
        
        addToFavoritesButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        productAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Actions
    @objc private func addToFavoritesButtonTapped() {
        if var productData {
            productData.isAdded.toggle()
        }
        updateFavoriteButtonState()
        saveChangesToCoreData()
    }
    
    // MARK: - Configure
    public func configure(viewModel: Product.ViewModel) {
        productData = viewModel
        productTitleLabel.text = viewModel.productTitle
        productImageView.image = UIImage(named: viewModel.productImage)
        productAmountLabel.text = viewModel.productAmount
        
        switch viewModel.isAdded {
        case true:
            addToFavoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            addToFavoritesButton.tintColor = .red
        case false:
            addToFavoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            addToFavoritesButton.tintColor = .white
        }
    }
    
    private func updateFavoriteButtonState() {
        guard let productData else { return }
        let imageName = productData.isAdded ? "heart.fill" : "heart"
        addToFavoritesButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func saveChangesToCoreData() {
        guard let productData else { return }
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        guard let context else { return }
        let fetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productTitle == %@", productData.productTitle)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let productData = results.first {
                productData.isAdded = productData.isAdded
                try context.save()
            }
        } catch {
            print("Failed to fetch or save context: \(error)")
        }
    }
    
}
