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
import ProgressHUD
import Lottie

protocol BuyProductDelegate: AnyObject {
    func presentSuccessPage(success: Bool)
}

final class BuyProductViewController: UIViewController {
    
    // MARK: - Deps
    let cardNumberListener = MaskedTextInputListener(primaryFormat: "[0000]-[0000]-[0000]-[0000]")
    let cardDateListener = MaskedTextInputListener(primaryFormat: "[00]/[00]")
    let cardCVVListener = MaskedTextInputListener(primaryFormat: "[000]")
    private let productData: Product.ViewModel
    weak var delegate: BuyProductDelegate?
    private var isShortForm: Bool = false
    private var additionalHeight: CGFloat = 0.0
    
    init(productData: Product.ViewModel) {
        self.productData = productData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var productView: ProductInfoView = {
        let view = ProductInfoView()
        view.configure(productData: productData)
        return view
    }()
    
    private lazy var cardNameTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        textField.title = "Имя карты"
        textField.titleColor = .lightGray
        textField.selectedTitleColor = .lightGray
        textField.placeholder = "Имя карты"
        textField.lineHeight = 0
        textField.selectedLineHeight = 0
        textField.keyboardType = .default
        textField.addTarget(self, action: #selector(checkCardInfo), for: .allEditingEvents)
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
        let iconImageView = UIImageView(image: UIImage(systemName: "creditcard.fill"))
        iconImageView.tintColor = .lightGray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        rightView.addSubview(iconImageView)
        iconImageView.center = rightView.center
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(checkCardInfo), for: .allEditingEvents)
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
        let iconImageView = UIImageView(image: UIImage(systemName: "calendar"))
        iconImageView.tintColor = .lightGray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        rightView.addSubview(iconImageView)
        iconImageView.center = rightView.center
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(checkCardInfo), for: .allEditingEvents)
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
        let iconImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
        iconImageView.tintColor = .lightGray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        rightView.addSubview(iconImageView)
        iconImageView.center = rightView.center
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(checkCardInfo), for: .allEditingEvents)
        return textField
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Купить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .lightGray
        button.tintColor = .white
        button.addTarget(self, action: #selector(buyProductButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
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
        view.addSubview(productView)
        view.addSubview(cardNameTextField)
        view.addSubview(cardNumberTextField)
        view.addSubview(stackView)
        stackView.addArrangedSubview(cardDateTextField)
        stackView.addArrangedSubview(cardCVVTextField)
        view.addSubview(buyButton)
        
        hideKeyboardWhenTappedAround()
    }
    
    private func setupConstraints() {
        productView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        cardNameTextField.snp.makeConstraints { make in
            make.top.equalTo(productView.snp.bottom).offset(32)
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
            make.top.equalTo(stackView.snp.bottom).offset(16)
        }
    }
    
    // MARK: - Actions
    @objc private func buyProductButtonTapped() {
        ProgressHUD.animate("Обработка", .activityIndicator, interaction: true)
        print(productData.productTitle)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            ProgressHUD.dismiss()
            if self.productData.productTitle == "iPhone 13 Pro Max" {
                self.showSuccessAnimation(success: false)
            } else {
                self.showSuccessAnimation(success: true)
            }
        }
    }
    
    @objc private func checkCardInfo() {
        
        let isCardNumberValid = !(cardNumberTextField.text?.isEmpty ?? true)
        let isCardNameValid = !(cardNameTextField.text?.isEmpty ?? true)
        let isCardDateValid = !(cardDateTextField.text?.isEmpty ?? true)
        let isCardCVVValid = !(cardCVVTextField.text?.isEmpty ?? true)
        
        if isCardNumberValid, isCardNameValid, isCardDateValid, isCardCVVValid {
            buyButton.isUserInteractionEnabled = true
            buyButton.backgroundColor = .systemGreen
        } else {
            buyButton.isUserInteractionEnabled = false
            buyButton.backgroundColor = .lightGray
        }
    }
    
    private func showSuccessAnimation(success: Bool) {
        let animationView = LottieAnimationView(name: success ? "success" : "failture")
        animationView.contentMode = .scaleAspectFill
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.addSubview(animationView)
            
            animationView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(100)
            }
            
            animationView.play { (finished) in
                self.dismiss(animated: true) {
                    self.delegate?.presentSuccessPage(success: success)
                }
                animationView.stop()
                animationView.removeFromSuperview()
            }
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        isShortForm = false
        additionalHeight = keyboardFrame.height
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        isShortForm = true
        additionalHeight = 0.0
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .shortForm)
    }
}

extension BuyProductViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(362)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(362 + additionalHeight)
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.3)
    }
    
    var cornerRadius: CGFloat {
        return 16
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var allowsDragToDismiss: Bool {
        return false
    }
    
    var allowsTapToDismiss: Bool {
        return false
    }
}
