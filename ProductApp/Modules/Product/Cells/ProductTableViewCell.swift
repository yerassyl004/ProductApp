//
//  ProductTableViewCell.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 03.06.2024.
//

import UIKit
import SnapKit

final class ProductTableViewCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var addToFavoritesImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var productAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [productTitleLabel, productImageView, productAmountLabel, addToFavoritesImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.size.equalTo(150)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        addToFavoritesImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.size.equalTo(16)
        }
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.trailing.equalTo(addToFavoritesImageView.snp.leading).offset(-8)
        }
        
        productAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
        }
    }
    
    // MARK: - Configure
    public func configure(viewModel: Product.ViewModel) {
        productTitleLabel.text = viewModel.productTitle
        productImageView.image = viewModel.productImage
        productAmountLabel.text = viewModel.productAmount
        
        addToFavoritesImageView.image = viewModel.isAdded ?
        UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
}
