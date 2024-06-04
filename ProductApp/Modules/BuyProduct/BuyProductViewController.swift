//
//  BuyProductViewController.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 04.06.2024.
//

import UIKit
import PanModal
import SkyFloatingLabelTextField
import InputMask
import SnapKit

final class BuyProductViewController: UIViewController {
    
    // MARK: - Deps
    let cardNumberListener = MaskedTextInputListener(primaryFormat: "[0000]-[0000]-[0000]-[0000]")
    let cardDateListener = MaskedTextInputListener(primaryFormat: "[00]/[00]")
    let cardCVVListener = MaskedTextInputListener(primaryFormat: "[000]")
    
    // MARK: - UI
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var cardNameTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        textField.title = "Имя карты"
        textField.titleColor = .lightGray
        textField.selectedTitleColor = .lightGray
        textField.placeholder = "Имя карты"
        textField.lineHeight = 0
        textField.selectedLineHeight = 0
        return textField
    }()
    
    private lazy var cardNumberTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        textField.title = "Номер карты"
        textField.titleColor = .lightGray
        textField.selectedTitleColor = .lightGray
        textField.placeholder = "Номер карты"
        textField.delegate = cardNumberListener
        textField.lineHeight = 0
        textField.selectedLineHeight = 0
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 48))
        let iconImageView = UIImageView(image: UIImage(systemName: "creditcard"))
        iconImageView.tintColor = .lightGray
        iconImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        rightView.addSubview(iconImageView)
        iconImageView.center = rightView.center
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var cardDateTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        textField.title = "Дата"
        textField.titleColor = .lightGray
        textField.selectedTitleColor = .lightGray
        textField.placeholder = "Дата"
        textField.delegate = cardDateListener
        textField.lineHeight = 0
        textField.selectedLineHeight = 0
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 48))
        let iconImageView = UIImageView(image: UIImage(systemName: "creditcard"))
        iconImageView.tintColor = .lightGray
        iconImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        rightView.addSubview(iconImageView)
        iconImageView.center = rightView.center
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var cardCVVTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        textField.title = "CVV"
        textField.titleColor = .lightGray
        textField.selectedTitleColor = .lightGray
        textField.placeholder = "CVV"
        textField.delegate = cardCVVListener
        textField.lineHeight = 0
        textField.selectedLineHeight = 0
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 48))
        let iconImageView = UIImageView(image: UIImage(systemName: "creditcard"))
        iconImageView.tintColor = .lightGray
        iconImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        rightView.addSubview(iconImageView)
        iconImageView.center = rightView.center
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Купить", for: .normal)
        button.backgroundColor = .systemGreen
        button.tintColor = .black
        button.addTarget(self, action: #selector(buyProductButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [cardNameTextField, cardNumberTextField, cardDateTextField, cardCVVTextField].forEach { textField in
            textField.layer.cornerRadius = 16
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }
        buyButton.layer.cornerRadius = buyButton.bounds.height / 2
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(cardNameTextField)
        view.addSubview(cardNumberTextField)
        view.addSubview(stackView)
        stackView.addArrangedSubview(cardDateTextField)
        stackView.addArrangedSubview(cardCVVTextField)
        view.addSubview(buyButton)
    }
    
    private func setupConstraints() {
        cardNameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        cardNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(cardNameTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        cardDateTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        cardCVVTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        buyButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
    }
    
    // MARK: - Actions
    @objc private func buyProductButtonTapped() {
        
    }

}

extension BuyProductViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(280)
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.3)
    }
    
    var cornerRadius: CGFloat {
        return 16
    }
}
