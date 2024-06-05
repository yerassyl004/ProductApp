//
//  ProductInfoView.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 05.06.2024.
//

import UIKit
import SnapKit

final class ProductInfoView: UIView {
    
    // MARK: - UI
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(productImageView)
        addSubview(productTitleLabel)
        addSubview(productAmountLabel)
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(60)
            make.bottom.equalToSuperview()
        }
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
        }
        
        productAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(6)
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    public func configure(productData: Product.ViewModel) {
        productImageView.image = UIImage(named: productData.productImage)
        productTitleLabel.text = productData.productTitle
        productAmountLabel.text = productData.productAmount
    }
    
}
