//
//  ProductInteractor.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 03.06.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductBusinessLogic {
    func getProductData()
}

protocol ProductDataStore {
    var productDetail: Product.ViewModel? { get set }
}

final class ProductInteractor: ProductDataStore {
    var productDetail: Product.ViewModel?
    var presenter: ProductPresentationLogic?
    var worker: ProductWorkerProtocol?

    init(worker: ProductWorkerProtocol, presenter: ProductPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension ProductInteractor: ProductBusinessLogic {
    func getProductData() {
        worker?.fetchProductData { [weak self] productData in
            self?.presenter?.presentProductData(model: productData)
        }
    }
}
