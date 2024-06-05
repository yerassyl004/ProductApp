//
//  SuccessViewViewController.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 05.06.2024.
//

import UIKit
import SnapKit

final class SuccessViewViewController: UIViewController {
    
    private let isSuccess: Bool
    
    init(success: Bool) {
        self.isSuccess = success
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var successImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: isSuccess ? "success_image" : "failure_image")
        return imageView
    }()
    
    private lazy var successLabel: UILabel = {
        let label = UILabel()
        label.text = isSuccess ? "Поздравляю" : "Ошибка"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.text = """
Ваш заказ был успешно обработан. Спасибо за покупку! Мы свяжемся с вами для подтверждения заказа.
"""
        label.text = isSuccess ? 
        "Ваш заказ был успешно обработан. Спасибо за покупку! Мы свяжемся с вами для подтверждения заказа." :
        "Произошла ошибка при обработке заказа. Пожалуйста, попробуйте еще раз."
                
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(successImageView)
        view.addSubview(successLabel)
        view.addSubview(informationLabel)
    }
    
    private func setupConstraints() {
        successImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        
        successLabel.snp.makeConstraints { make in
            make.top.equalTo(successImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(successLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }

}
