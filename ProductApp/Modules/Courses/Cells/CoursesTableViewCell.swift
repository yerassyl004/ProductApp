//
//  CoursesTableViewCell.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 03.06.2024.
//

import UIKit
import SnapKit

final class CoursesTableViewCell: UITableViewCell {

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
    
    private lazy var addToFavoritesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.layer.shadowOpacity = 10
        return imageView
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .systemGray6
        [productTitleLabel, productImageView, productAmountLabel, addToFavoritesImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(120)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        addToFavoritesImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.trailing.equalTo(addToFavoritesImageView.snp.leading).inset(8)
        }
        
        productAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(16)
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
        }
    }
    
    // MARK: - Configure
    public func configure(viewModel: Product.ViewModel) {
        productTitleLabel.text = viewModel.productTitle
        productImageView.image = UIImage(named: viewModel.productImage)
        productAmountLabel.text = viewModel.productAmount
        
        switch viewModel.isAdded {
        case true:
            addToFavoritesImageView.image = UIImage(systemName: "heart.fill")
            addToFavoritesImageView.tintColor = .red
        case false:
            addToFavoritesImageView.image = UIImage(systemName: "heart")
            addToFavoritesImageView.tintColor = .white
        }
    }

}
